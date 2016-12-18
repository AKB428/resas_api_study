require 'httpclient'
require 'json'

api_key = ARGV[0] #第1引数にAPIキーを指定
prefCode = ARGV[1] #第2引数に県コードを指定
cityCode = ARGV[2] #第3引数に県コードを指定

END_POINT = 'https://opendata.resas-portal.go.jp'
API_PATH = 'api/v1-rc.1/population/sum/estimate'
http_client = HTTPClient.new
query = { 'prefCode' => prefCode, 'cityCode' => cityCode }
url = File.join(END_POINT, API_PATH)
auth_header = {
    'X-API-KEY' => api_key
}
response = http_client.get_content(URI.parse(URI.encode(url)), query, auth_header)
puts response