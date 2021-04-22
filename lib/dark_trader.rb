require 'rspec'
require 'pry'
require 'rubocop'
require 'nokogiri'
require 'open-uri'

page_url = "https://coinmarketcap.com/all/views/all/"

page = Nokogiri::HTML(URI.open(page_url))

crypto_name_array = page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
crypto_price_array = page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a')

# puts in a hash crypto name as key and crypto price as value
def linker(crypto_name, crypto_price)
    crypto_h = Hash.new
    crypto_h[crypto_name] = crypto_price.gsub(/\$|,/, '').to_f
    crypto_h
end

# puts crypto key value pairs in an array
def hash_linker(name_array, price_array)
    crypto_name_price_array = []
    for i in 0..name_array.length - 1 do
        puts linker(name_array[i].text, price_array[i].text)
        crypto_name_price_array.push(linker(name_array[i].text, price_array[i].text))
    end
    crypto_name_price_array
end

puts "#{hash_linker(crypto_name_array, crypto_price_array)}"