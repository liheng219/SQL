--  Contract Risk Alert

WITH contract_alert AS (

    SELECT
        contract_id,
        customer_id,
        sale_id,
        contract_end_date,

        DATEDIFF(
            contract_end_date,
            CURDATE()
        ) AS days_to_expiry

    FROM contracts
)

SELECT *,

    CASE
     WHEN days_to_expiry <= 7
     THEN 'CRITICAL'
     WHEN days_to_expiry <= 30
     THEN 'WARNING'
    ELSE 'NORMAL'
    END AS risk_status

FROM contract_alert;
