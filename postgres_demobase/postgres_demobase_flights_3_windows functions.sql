SELECT
    route_no,
    DATE(scheduled_departure) AS dep_date,
    status,
    COUNT(*) OVER (
        PARTITION BY route_no, DATE(scheduled_departure)
    ) AS flights_same_route_day
FROM flights
ORDER BY route_no, dep_date, scheduled_departure;


SELECT
    route_no,
    scheduled_departure,
    ROW_NUMBER() OVER (
        PARTITION BY route_no
        ORDER BY scheduled_departure
    ) AS flight_number_in_route
FROM flights;
--rgtret

