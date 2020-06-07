library(tidyquant)
library(ggplot2)
library(lubridate)
library(httr)
library(jsonlite)
library(stringr)
library(glue)
library(tidyverse)
library(alphavantager)

#data_directory <- "E:/market_data/crypto"
#crypto_name <- "ethereum"
#time_series <- "day"

#loaded_data <- read_json(paste0(data_directory, '/', crypto_name, '/', time_series, '.json'), simplifyVector = FALSE)
#meta_data <- loaded_data[[1]]
#chart_data <- loaded_data[[2]]

#av_api_key("E6Q1EY5PCMCFQ8MJ")

#data_tibble = tq_get("ETH", get = "alphavantager", av_fun = "DIGITAL_CURRENCY_DAILY", market = "USD")
#data_frame_tibble = as.data.frame(data_tibble)
#write_json(data_frame_tibble, 'E:/market_data/crypto/ethereum/day.json', pretty = TRUE, digits = 7)
#data_frame_json = read_json('E:/market_data/crypto/ethereum/day.json', simplifyDataFrame = TRUE)

av_api_key <- "E6Q1EY5PCMCFQ8MJ"
data_directory <- "E:/market_data/crypto"

av_crypto_query <- function(crypto_id, time_series)
{
  t_series = ""
  if (time_series == "day")
    t_series = "DIGITAL_CURRENCY_DAILY"
  else if (time_series == "week")
    t_series = "DIGITAL_CURRENCY_WEEKLY"
  else if (time_series == "month")
    t_series = "DIGITAL_CURRENCY_MONTHLY"
    
  dat_tibble = tq_get(crypto_id, get = "alphavantager", av_fun = t_series, market = "USD")
  dat
}