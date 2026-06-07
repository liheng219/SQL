-- Achievement Rate= CommittedVolume/Actual Volume​×100

-- tính tổng vol của từng khách hàng theo tháng
WITH shipment_sum AS (  
	
    SELECT
        customer_id,
        SUM(shipment_volume) AS actual_volume,
        -- đưa tất cả ngày trong tháng về ngày đầu tháng
        DATE_SUB(shipment_date, INTERVAL DAYOFMONTH(shipment_date) - 1 DAY) AS shipment_month_date 
    FROM shipments
    WHERE delivery_status = 'Delivered'
    GROUP BY customer_id, DATE_SUB(shipment_date, INTERVAL DAYOFMONTH(shipment_date) - 1 DAY)
),
-- tinh% actual_volum/committed_vol va revenue của từng khách theo tháng
Achievement AS ( 
    SELECT
        c.sale_id,
        c.customer_id,
        discounted_price,
		standard_price,
        c.committed_volume,
        s.shipment_month_date,
        -- trường hợp khách hàng ko order (null) sễ nhận giá trị 0
        COALESCE(s.actual_volume, 0) AS actual_volume, 

        -- Tính doanh thu theo điều kiện sản lượng đạt cam kết
        ROUND(
            COALESCE(s.actual_volume, 0) * 
            CASE 
                WHEN COALESCE(s.actual_volume, 0) >= c.committed_volume THEN c.discounted_price
                ELSE c.standard_price -- Áp giá chuẩn 
            END, 
            2
        ) AS shipment_revenue,

        ROUND(
            COALESCE(s.actual_volume, 0) * 100.0 / NULLIF(c.committed_volume, 0), -- đảm bảo mẫu số không âm
            2
        ) AS achievement_rate
    FROM contracts c
    LEFT JOIN shipment_sum s
        ON c.customer_id = s.customer_id
)

SELECT 
    sale_id,
    customer_id,
    committed_volume,
    discounted_price,
    standard_price,
    shipment_month_date,
    actual_volume,
    shipment_revenue,
    achievement_rate,
    CASE
        WHEN achievement_rate < 100  THEN 'Không đạt sản lượng' 
        ELSE 'Đạt'
    END AS risk_status
FROM Achievement;