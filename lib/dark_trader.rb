require 'rspec'
require 'pry'
require 'rubocop'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://en.wikipedia.org/wiki/HTML"

page = Nokogiri::HTML(URI.open(PAGE_URL))

# crypto_name_array = page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[1]/td[3]/div')

puts page
# puts crypto_name_array.text