require 'net/http'
require 'json'
require 'uri'

class ProductApiService
  def self.fetch_products
    url = URI('https://dummyjson.com/products')
    response = Net::HTTP.get(url)
    JSON.parse(response)['products']
  end
end
