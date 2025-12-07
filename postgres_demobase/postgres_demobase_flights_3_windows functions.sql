-- Количество рейсов по маршруту на каждую дату
SELECT
    route_no,
    DATE(scheduled_departure) AS dep_date,
    status,
    COUNT(*) OVER (
        PARTITION BY route_no, DATE(scheduled_departure)
    ) AS flights_same_route_day
FROM flights
ORDER BY route_no, dep_date, scheduled_departure;


-- Порядковый номер рейса внутри маршрута
SELECT
    route_no,
    scheduled_departure,
    ROW_NUMBER() OVER (
        PARTITION BY route_no
        ORDER BY scheduled_departure
    ) AS flight_number_in_route
FROM flights;


-- Средняя длительность полетов между одинаковыми парами аэропортов
SELECT
    departure_airport,
    arrival_airport,
    duration,
    AVG(duration) OVER (PARTITION BY departure_airport, arrival_airport) AS flights_avg
FROM routes;

