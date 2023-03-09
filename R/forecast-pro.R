


#' Weather forecast data request (4 days with hourly data)
#' @details Note that this function requires a professional account in OpenWeather
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
weather_forecast_req_hourly <- function(lat, lon, api_key = Sys.getenv("weather_key"), lang = "en", units = "standard", tibble_format = TRUE){

  request <-
    paste0("https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=",lat,
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


#' Weather forecast data request by name (4 days with hourly data)
#' @details Note that this function requires a professional account in OpenWeather
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
weather_state_forecast_hourly <- function(api_key = Sys.getenv("weather_key"), lang = "en", units = "standard",name, tibble_format = TRUE){

  request <-
    paste0("https://pro.openweathermap.org/data/2.5/forecast/hourly?","&appid=",api_key,"&lang=",lang,"&units=",units,
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

#' Weather forecast data request (Daily data by 16 days)
#' @details Note that this function requires a professional account in OpenWeather
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
weather_forecast_req_hourly <- function(lat, lon, api_key = Sys.getenv("weather_key"), lang = "en", units = "standard", tibble_format = TRUE){

  request <-
    paste0("https://pro.openweathermap.org/data/2.5/forecast/daily?lat=",lat,
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


#' Weather forecast data request by name (Daily data by 16 days)
#' @details Note that this function requires a professional account in OpenWeather
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
weather_state_forecast_hourly <- function(api_key = Sys.getenv("weather_key"), lang = "en", units = "standard",name, tibble_format = TRUE){

  request <-
    paste0("https://pro.openweathermap.org/data/2.5/forecast/daily?","&appid=",api_key,"&lang=",lang,"&units=",units,
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






