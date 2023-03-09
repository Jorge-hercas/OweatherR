

#' Weather forecast data request (5 days. Data every 3 hours)
#'
#' @param lat Latitude in decimals
#' @param lon Longitude in decimals
#' @param api_key API key from OpenWeather (not necessary if an API key was previosly set)
#' @param lang Supported languaje
#' @param units Units of measurement. The type of unit of measure can be "standard" (default), "metric" and "imperial"
#' @param tibble_format Logical value. If it is TRUE returns the request on tibble format
#'
#' @return
#' @export
#'
#' @examples
weather_forecast_req <- function(lat, lon, api_key = Sys.getenv("weather_key"), lang = "en", units = "standard", tibble_format = TRUE){

  request <-
    paste0("https://api.openweathermap.org/data/2.5/forecast?lat=",lat,
           "&lon=",lon,"&appid=",api_key,"&lang=",lang,"&units=",units)

  tryCatch({
    data <- if (tibble_format == TRUE)
      jsonlite::fromJSON(request)$list
    else httr::content(httr::GET(request), "parsed")

    data$dt <- lubridate::as_datetime(data$dt)
    return(data)
  }, error = function(e){
    stop("Error to collect the data. Is your API Key active?")
  })

}


#' Weather forecast data request by name (5 days. Data every 3 hours)
#'
#' @param api_key API key from OpenWeather (not necessary if an API key was previosly set)
#' @param lang Supported languaje
#' @param units Units of measurement. The type of unit of measure can be "standard" (default), "metric" and "imperial"
#' @param name String with the name of a state (only works for the USA) or country
#' @param tibble_format Logical value. If it is TRUE returns the request on tibble format
#'
#' @return
#' @export
#'
#' @examples
weather_state_forecast <- function(api_key = Sys.getenv("weather_key"), lang = "en", units = "standard",name, tibble_format = TRUE){

  request <-
    paste0("https://api.openweathermap.org/data/2.5/forecast?","&appid=",api_key,"&lang=",lang,"&units=",units,
           "&q=",name
    )

  tryCatch({
    data <- if (tibble_format == TRUE)
      jsonlite::fromJSON(request)$list
    else httr::content(httr::GET(request), "parsed")

    data$dt <- lubridate::as_datetime(data$dt)
    return(data)
  }, error = function(e){
    stop("Error to collect the data. Is your API Key active?")
  })

}









