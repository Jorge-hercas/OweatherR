# OweatherR

Package to easily connect to the OpenWeather API. The package automatically encodes OpenWeather API requests to be read in R in Json format or directly transformed into a Tibble.


## Installation
You can download the package using the following command:

```
devtools::install_github("Jorge-hercas/OweatherR")
```
OpenWeather is a weather information system that allows you to obtain data through its API. To use the library you must register on their page (https://openweathermap.org) and activate an API key. Once registered, you can make queries with this library, for example:

```
library(OweatherR)
weather_actual_req(lat = 19, lon = -19, api_key = "YOUR API KEY", tibble_format = TRUE)
```
The result will be:
```
# A tibble: 1 x 27
  coord.lon coord.lat weather.id weather.main weather.description weather.icon base     main.temp
      <int>     <int>      <int> <chr>        <chr>               <chr>        <chr>        <dbl>
1       -19        19        800 Clear        clear sky           01d          stations      293.
# … with 19 more variables: main.feels_like <dbl>, main.temp_min <dbl>, main.temp_max <dbl>,
#   main.pressure <int>, main.humidity <int>, main.sea_level <int>, main.grnd_level <int>,
#   visibility <int>, wind.speed <dbl>, wind.deg <int>, wind.gust <dbl>, all <int>, dt <int>,
#   sys.sunrise <int>, sys.sunset <int>, timezone <int>, id <int>, name <chr>, cod <int>
```
Or you can make a query for historical data, for example:
```
weather_historic_req(lat = 19, lon = -19, api_key = "YOUR API KEY", date = "2022-01-01", tibble_format = TRUE)
```
Using the equivalent function `weather_state_historic()` you can get the data from the country name or state name (just for USA).
You can also get forecasts, massive historical data and air pollution.

The package includes a data frame with all the available cities, with their respective latitude and longitude, but you can also use the function `get_coordinates()` to get this info, for example:

```
get_coordinates("Mexico", "CDMX", api_key = "YOUR API KEY")
```
An you get the following result:

```
# A tibble: 1 x 4
  country state         lat   lon
  <chr>   <chr>       <dbl> <dbl>
1 MX      Mexico City  19.4 -99.1
```








