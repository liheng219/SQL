-- tinh hoa dong cho doi Sales
WITH shipment_sum AS (  
    SELECT
        customer_id,
        SUM(shipment_volume) AS actual_volume,
        DATE_SUB(shipment_date, INTERVAL DAYOFMONTH(shipment_date) - 1 DAY) AS shipment_month_date
    FROM shipments
    WHERE delivery_status = 'Delivered'
    GROUP BY customer_id, shipment_month_date
),
contract_revenue AS (
    
    SELECT
        c.sale_id,
        c.customer_id,
        s.shipment_month_date,
        COALESCE(s.actual_volume, 0) AS actual_volume,
        c.committed_volume,
        ROUND(
            COALESCE(s.actual_volume, 0) * 
            IF(COALESCE(s.actual_volume, 0) >= c.committed_volume, c.discounted_price, c.standard_price), 
            2
        ) AS shipment_revenue
    FROM shipment_sum s
    LEFT JOIN  contracts c ON c.customer_id = s.customer_id
),
Achievement AS ( 
    -- 3. Tổng hợp sản lượng và doanh thu theo Sale và Tháng
    SELECT
        sale_id,
        shipment_month_date,
        SUM(actual_volume) AS total_actual_volume,
        SUM(shipment_revenue) AS total_revenue
    FROM contract_revenue
    GROUP BY sale_id, shipment_month_date
)

SELECT  
    k.sale_id,
    k.target_month,
    k.target_revenue,
    COALESCE(a.total_revenue, 0) AS total_revenue,
    
    -- Tính % hoàn thành KPI bằng NULLIF 
    ROUND(COALESCE(a.total_revenue, 0) * 100.0 / NULLIF(k.target_revenue, 0), 2) AS kpi_completion_rate,
    
    -- Tính hoa hồng 
    ROUND(
        IF(
            k.target_revenue = 0 OR (COALESCE(a.total_revenue, 0) / k.target_revenue) < 0.8, 
            0, 
            (LEAST(COALESCE(a.total_revenue, 0), k.target_revenue) * r.rate_tier2) 
            + (GREATEST(0, COALESCE(a.total_revenue, 0) - k.target_revenue) * r.rate_tier3)
        ), 2
    ) AS commission_amount
FROM sales_kpi_targets k
LEFT JOIN Achievement a
    ON k.sale_id = a.sale_id
    AND k.target_month = a.shipment_month_date
CROSS JOIN (
    -- Lấy cấu hình tỷ lệ hoa hồng tĩnh
    SELECT 
        MAX(CASE WHEN rate_id = 2 THEN rate_percent END) AS rate_tier2, 
        MAX(CASE WHEN rate_id = 3 THEN rate_percent END) AS rate_tier3  
    FROM commission_rates
) r;

-- kết nối file với power BI để làm report
