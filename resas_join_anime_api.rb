require 'httpclient'
require 'json'
require 'shangrila'

# bundle exe ruby resas_join_anime_api.rb {API_KEY}

api_key = ARGV[0] #第1引数にAPIキーを指定

END_POINT = 'https://opendata.resas-portal.go.jp'
API_PATH = 'api/v1-rc.1/population/sum/estimate'
http_client = HTTPClient.new
url = File.join(END_POINT, API_PATH)
auth_header = {
    'X-API-KEY' => api_key
}

# 2016年3期(6月-9月),4期(10月-12月)のアニメデータを取得
anime_masters = Shangrila::Sora.new().get_map_key_id(2016, 3)
c4 = Shangrila::Sora.new().get_map_key_id(2016, 4)
anime_masters.update(c4)

anime_masters.each do |anime_master|

  if anime_master[1]['city_code'] > 0

    city_code = anime_master[1]['city_code']
    pref_code = city_code.to_s[0, 2]

    query = { 'prefCode' => pref_code, 'cityCode' => city_code }
    resas_response_json = http_client.get_content(URI.parse(URI.encode(url)), query, auth_header)
    resas_response = JSON.load(resas_response_json)
    souzinkou =  resas_response['result']['data'][0]['data']

    souzinkou2015 = nil

    souzinkou.each do |s|
      souzinkou2015 = s['value'] if s['year'] == 2015
    end

    puts "#{anime_master[1]['title']}(#{anime_master[1]['city_name']}),#{souzinkou2015}"
  end
end