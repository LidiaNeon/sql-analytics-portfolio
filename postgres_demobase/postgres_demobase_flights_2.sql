SELECT 
    (actual_departure - scheduled_departure) AS delay,
    COUNT(*) 
FROM flights
WHERE actual_departure IS NOT NULL
GROUP BY delay
ORDER BY delay DESC;