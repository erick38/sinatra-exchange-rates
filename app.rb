require "sinatra"
require "sinatra/reloader"
require "http"
require "dotenv/load"

# Root route
get("/") do
  @get_http = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch('access_key')}")
  @string_http =  @get_http.to_s
  @parse_http = JSON.parse(@string_http)
  @currencies = @parse_http.fetch('currencies')

  pp @get_http # Debugging to ensure we fetch the data
  erb :homepage
end
get("/:first_symbol") do
  @f_symbol = params.fetch("first_symbol")
  @get_http = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch('access_key')}")
  @string_http =  @get_http.to_s
  @parse_http = JSON.parse(@string_http)
  @currencies = @parse_http.fetch('currencies')

  pp @get_http # Debugging to ensure we fetch the data
  erb :symbol_templ
end

get("/:first_symbol/:second_symbol") do
  @from = params.fetch("first_symbol")
  @to = params.fetch("second_symbol")
  @url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("access_key")}&from=#{@from}&to=#{@to}&amount=1"
  @raw = HTTP.get(@url)
  @string_response = @raw.to_s
  @parse_response = JSON.parse(@string_response)
  @amount = @parse_response.fetch('result')
  erb :from_to
end
