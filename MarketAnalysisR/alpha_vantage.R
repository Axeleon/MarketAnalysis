library(quantmod)
library(ggplot2)
library(lubridate)
library(httr)
library(jsonlite)
library(stringr)
library(glue)

#Use coingecko for intraday trading
#intraday_base <- "https://api.coingecko.com/api/v3/"
#intraday_endpoint <- "ping"

#Use AlphaVantage for historical data
av_api_key <- "E6Q1EY5PCMCFQ8MJ"
data_directory <- "E:/market_data/crypto"

#AlphaVantage query
av_query <- function(av_func, ...)
{
  params <- list(...)
  
  endpoint = str_c(names(params), params, sep = "=", collapse = "&")
  response = GET(glue("https://www.alphavantage.co/query?function={av_func}&{endpoint}&apikey={av_api_key}"))
  if (http_type(response) != "application/json")
  {
    stop("API did not return json", call. = FALSE)
  }
  
  return(fromJSON(content(response, "text"), simplifyVector = FALSE))
}

save_historical_query <- function(av_h_func, h_symbol, h_market, dir_name, sub_dir_name)
{
  save_data = av_query(av_func = av_h_func, symbol = h_symbol, market = h_market, dir_name, sub_dir_name)
  dir.create(file.path(dir_name, sub_dir_name)) # This won't crash if we already have a dir so it's ok
  
  time_series = ""
  if (av_h_func == "DIGITAL_CURRENCY_DAILY")
    time_series = "day"
  else if (av_h_func == "DIGITAL_CURRENCY_WEEKLY")
    time_series = "week"
  else if (av_h_func == "DIGITAL_CURRENCY_MONTHLY")
    time_series = "month"
    
  full_dir = paste0(dir_name, '/', sub_dir_name, '/', time_series, '.json')
  write_json(save_data, full_dir, pretty = TRUE)

  return(save_data)
}

#data_parsed = save_historical_query("DIGITAL_CURRENCY_MONTHLY", "DOGE", "USD", data_directory, "dogecoin")