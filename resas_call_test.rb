require 'httpclient'
require 'json'

api_key = nil

File.open './config/config.json' do |file|
  conf = JSON.load(file.read)
  api_key = conf['RESAS']['api_key']
end

END_POINT = 'https://opendata.resas-portal.go.jp'

API_PATH = 'api/v1-rc.1/prefectures'

http_client = HTTPClient.new
query = nil
url = File.join(END_POINT, API_PATH)

#https://opendata.resas-portal.go.jp/docs/api/v1-rc.1/detail/index.html
auth_header = {
    'X-API-KEY' => api_key
}

result = http_client.get_content(URI.parse(URI.encode(url)), query, auth_header)

p result