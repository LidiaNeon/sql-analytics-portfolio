WITH red AS (
    SELECT flight_id, route_no
    FROM flights
    WHERE scheduled_departure > '2025-11-01'
),
route_revenue AS (
    SELECT
        r.route_no,
        SUM(s.price) AS total_revenue
    FROM red r
    JOIN segments s ON s.flight_id = r.flight_id
    GROUP BY r.route_no
)
SELECT
    route_no,
    total_revenue
FROM route_revenue
ORDER BY total_revenue DESC
LIMIT 10;
