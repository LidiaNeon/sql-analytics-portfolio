-- Table: sales
-- - id          BIGINT        -- уникальный идентификатор транзакции
-- - order_date  DATE          -- дата заказа
-- - product_id  INT           -- идентификатор товара
-- - quantity    INT           -- количество
-- - price       NUMERIC(10,2) -- цена за единицу

-- Case 01 — Monthly Revenue Calculation
WITH monthly_revenue AS (
    SELECT
        product_id,
        DATE_TRUNC('month', order_date) AS month_start,
        SUM(quantity * price) AS revenue
    FROM sales
    GROUP BY product_id, DATE_TRUNC('month', order_date)
),
with_prev AS (
    SELECT
        product_id,
        month_start,
        revenue,
        LAG(revenue) OVER (
            PARTITION BY product_id
            ORDER BY month_start
        ) AS prev_month_revenue
    FROM monthly_revenue
)
SELECT
    product_id,
    month_start,
    revenue,
    prev_month_revenue,
    ROUND(
        CASE
            WHEN prev_month_revenue IS NULL OR prev_month_revenue = 0
            THEN NULL
            ELSE (revenue - prev_month_revenue) / prev_month_revenue * 100
        END
    , 2) AS mom_growth_pct
FROM with_prev
ORDER BY product_id, month_start;