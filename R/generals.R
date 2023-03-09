




#' Set weather API key
#'
#' @param api_key API key from OpenWeather
#'
#' @return
#' @export
#'
#' @examples
set_weather_key <- function(api_key){

  Sys.setenv(weather_key = api_key)

}

#' Historic weather data request (A single observation of the past)
#'
#' @param lat Latitude in decimals
#' @param lon Longitude in decimals
#' @param api_key API key from OpenWeather (not necessary if an API key was previosly set)
#' @param lang Supported languaje
#' @param units Units of measurement. The type of unit of measure can be "standard" (default), "metric" and "imperial"
#' @param date Date in format YYYY/MM/DD. The most current date must be at least 5 days before the current day
#' @param tibble_format Logical value. If it is TRUE returns the request on tibble format
#'
#' @return
#' @export
#'
#' @examples
weather_historic_req <- function(lat, lon, api_key = Sys.getenv("weather_key"), lang = "en", units = "standard",date = "2023-01-01", tibble_format = FALSE){

  dtime <- round(as.numeric(lubridate::as_datetime(date)))

  request <-
    paste0("http://api.openweathermap.org/data/3.0/onecall/timemachine?lat=",lat,
           "&lon=",lon,"&dt=",dtime,"&appid=",api_key,"&lang=",lang,"&units=",units)

  tryCatch({
    data <- if (tibble_format == TRUE)
      dplyr::as_tibble(as.data.frame(httr::content(httr::GET(request), "parsed")))
    else httr::content(httr::GET(request), "parsed")
    return(data)
  }, error = function(e){
    stop("Error to collect the data. Is your API Key active?")
  })

}


#' Historic weather data request (A single observation of the past)
#'
#' @param api_key API key from OpenWeather (not necessary if an API key was previosly set)
#' @param lang Supported languaje
#' @param units Units of measurement. The type of unit of measure can be "standard" (default), "metric" and "imperial"
#' @param name String with the name of a state (only works for the USA) or country
#' @param date Date in format YYYY/MM/DD. The most current date must be at least 5 days before the current day
#' @param tibble_format Logical value. If it is TRUE returns the request on tibble format
#'
#' @return
#' @export
#'
#' @examples
weather_state_historic <- function(api_key = Sys.getenv("weather_key"), lang = "en", units = "standard",name,date = "2023-01-01", tibble_format = FALSE){

  dtime <- round(as.numeric(lubridate::as_datetime(date)))

  request <-
    paste0("https://api.openweathermap.org/data/2.5/weather?dt=",dtime,"&appid=",api_key,"&lang=",lang,"&units=",units,
           "&q=",name
           )

  tryCatch({
    data <-if (tibble_format == TRUE)
      dplyr::as_tibble(as.data.frame(httr::content(httr::GET(request), "parsed")))
    else httr::content(httr::GET(request), "parsed")
    return(data)
  }, error = function(e){
    stop("Error to collect the data. Is your API Key active?")
  })

}



#' Generic function to obtain coordinates from country/state
#'
#' @param country String with country name
#' @param state String with state name
#' @param api_key API key from OpenWeather (not necessary if an API key was previosly set)
#' @param only_coordinates Logical value. If it is TRUE it will only return the coordinates on a data frame. FALSE by default.
#'
#' @return
#' @export
#'
#' @examples
get_coordinates <- function(country, state, api_key = Sys.getenv("weather_key"), only_coordinates = FALSE){

  request <- paste0("http://api.openweathermap.org/geo/1.0/direct?q=",state,",",country,"&appid=",api_key,"&limit=1&lang=en")

  data <- httr::content(httr::GET(request), "parsed")

  table <- if(only_coordinates == FALSE){
    dplyr::tibble(
      country = data[[1]]$country,
      state = data[[1]]$name,
      lat = data[[1]]$lat,
      lon = data[[1]]$lon
    )
  }else{
    dplyr::tibble(
      lat = data[[1]]$lat,
      lon = data[[1]]$lon
    )
  }

  return(table)
}














