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
