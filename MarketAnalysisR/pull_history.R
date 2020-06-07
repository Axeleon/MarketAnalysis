library(quantmod)
library(ggplot2)
library(lubridate)
library (httr)
library (jsonlite)

base <- "https://api.coingecko.com/api/v3/"
endpoint <- "coins/ethereum/market_chart?vs_currency=usd&days=max"
file_path <- "E:\\market_data\\crypto\\ethereum.json"

response <- GET(url = paste0(base, endpoint))
if (http_type(response) != "application/json")
{
  stop("API did not return json", call. = FALSE)
}

parsed <- fromJSON(content(response, "text"), simplifyVector = FALSE)

write_json(parsed, file_path, pretty = TRUE)
#read_data <- read_json("E:\\market_data\\crypto\\ethereum.json", simplifyVector = FALSE)
#parsed_read <- parse_json(read_data, simplifyVector = TRUE)