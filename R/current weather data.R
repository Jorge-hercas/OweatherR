


#' Actual weather data request
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
weather_actual_req <- function(lat, lon, api_key = Sys.getenv("weather_key"), lang = "en", units = "standard", tibble_format = FALSE){

  request <-
    paste0("https://api.openweathermap.org/data/2.5/weather?lat=",lat,
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



#' Actual weather data request by name
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
weather_state_actual <- function(api_key = Sys.getenv("weather_key"), lang = "en", units = "standard",name, tibble_format = FALSE){

  request <-
    paste0("https://api.openweathermap.org/data/2.5/weather?","&appid=",api_key,"&lang=",lang,"&units=",units,
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







