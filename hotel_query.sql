

WITH hotels AS (
    SELECT *
    FROM dbo.['2018$']
    UNION
    SELECT *
    FROM dbo.['2019$']
    UNION
    SELECT *
    FROM dbo.['2020$']
    )

    SELECT arrival_date_year as 'Arrival Year', hotel as 'Hotel' , ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr), 2) as 'Total Stay Revenue'
    FROM hotels
    GROUP BY arrival_date_year, hotel;
    SELECT *
    FROM hotels
    LEFT JOIN market_segment$
        ON hotels.market_segment = market_segment$.market_segment
    LEFT JOIN meal_cost$
        ON meal_cost$.meal = hotels.meal;

"Added Custom" = Table.AddColumn(Source, "New Column (Revenue)", each ([stays_in_week_nights] + [stays_in_weekend_nights]) * ([adr] * [Discount])),
"Renamed Columns" = Table.RenameColumns("Added Custom",{{"New Column (Revenue)", "Revenue (New Column)"}})
