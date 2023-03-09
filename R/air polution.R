
#' Air polution data
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
air_polution <- function(lat, lon, api_key = Sys.getenv("weather_key"), lang = "en", units = "standard", tibble_format = FALSE){

  request <-
    paste0("http://api.openweathermap.org/data/2.5/air_pollution?lat=",lat,
           "&lon=",lon,"&appid=",api_key,"&lang=",lang,"&units=",units)

  tryCatch({
    data <- if (tibble_format == TRUE)
      dplyr::as_tibble(as.data.frame(httr::content(httr::GET(request), "parsed")))
    else httr::content(httr::GET(request), "parsed")
    return(data)
  }, error = function(e){
    stop("Error to collect the data. Is your API Key active?")
  })

}

#' Air polution forecast data
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
air_polution_forecast <- function(lat, lon, api_key = Sys.getenv("weather_key"), lang = "en", units = "standard", tibble_format = FALSE){

  request <-
    paste0("http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=",lat,
           "&lon=",lon,"&appid=",api_key,"&lang=",lang,"&units=",units)

  tryCatch({
    data <- if (tibble_format == TRUE)
      jsonlite::fromJSON(request)
    else httr::content(httr::GET(request), "parsed")

    data$list$dt <- lubridate::as_datetime(data$list$dt)
    return(data)
  }, error = function(e){
    stop("Error to collect the data. Is your API Key active?")
  })

}


#' Air polution historical data
#'
#' @param lat Latitude in decimals
#' @param lon Longitude in decimals
#' @param api_key API key from OpenWeather (not necessary if an API key was previosly set)
#' @param lang Supported languaje
#' @param units Units of measurement. The type of unit of measure can be "standard" (default), "metric" and "imperial"
#' @param start_date Initial date in format YYYY/MM/DD.
#' @param end_date Final date in format YYYY/MM/DD.
#' @param tibble_format Logical value. If it is TRUE returns the request on tibble format
#'
#' @return
#' @export
#'
#' @examples
air_polution_historical <- function(lat, lon, api_key = Sys.getenv("weather_key"), lang = "en", units = "standard", tibble_format = FALSE, start_date = "2021-01-01", end_date = "2021-01-02"){

  start_date <- round(as.numeric(lubridate::as_datetime(start_date)))
  end_date <- round(as.numeric(lubridate::as_datetime(end_date)))

  request <-
    paste0("http://api.openweathermap.org/data/2.5/air_pollution/history?lat=",lat,
           "&lon=",lon,"&appid=",api_key,"&lang=",lang,"&units=",units, "&start=",start_date,
           "&end=",end_date
           )

  tryCatch({
    data <- if (tibble_format == TRUE)
      jsonlite::fromJSON(request)
    else httr::content(httr::GET(request), "parsed")

    data$list$dt <- lubridate::as_datetime(data$list$dt)
    return(data)
  }, error = function(e){
    stop("Error to collect the data. Is your API Key active?")
  })

}
