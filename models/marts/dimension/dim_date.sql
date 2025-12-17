{{ config(
    materialized='table',
    schema='bi'
) }}

with date_spine as (

    select explode(
        sequence(
            to_date('2015-01-01'),
            to_date('2035-12-31'),
            interval 1 day
        )
    ) as date

)

select
    cast(date_format(date, 'yyyyMMdd') as int) as date_key,
    date                                    as date,
    year(date)                              as year,
    month(date)                             as month,
    date_format(date, 'MMMM')               as month_name,
    day(date)                               as day,
    dayofweek(date)                         as day_of_week,
    date_format(date, 'EEEE')               as day_name,
    weekofyear(date)                        as week_of_year,
    quarter(date)                           as quarter,
    case when dayofweek(date) in (1,7) then true else false end as is_weekend,
    current_timestamp()                     as created_ts

from date_spine
