-- Revenue Leakage=(Standard Price−Discounted Price)×Actual Volume
 WITH shipment_sum AS (  -- tính tổng vol của từng khách hàng theo tháng
    SELECT
        customer_id,
        SUM(shipment_volume) AS actual_volume,
        DATE_SUB(s.shipment_date, INTERVAL DAYOFMONTH(s.shipment_date) - 1 DAY) AS shipment_month_date -- đưa tất cả ngày trong tháng về ngày đầu tháng
    FROM shipments s
    WHERE delivery_status = 'Delivered'
    GROUP BY customer_id, shipment_month_date
)
    SELECT
        c.sale_id,
        c.customer_id,
        c.committed_volume,
        s.shipment_month_date,
        COALESCE(s.actual_volume, 0) AS actual_volume, -- trường hợp khách hàng ko order (null) sễ nhận giá trị 0

        CASE
			 WHEN COALESCE(s.actual_volume, 0) < c.committed_volume
             THEN COALESCE(s.actual_volume, 0) *(c.standard_price-c.discounted_price)
             ELSE 0
        END AS revenue_leakage

    FROM contracts c
    LEFT JOIN shipment_sum s
        ON c.customer_id = s.customer_id;

 