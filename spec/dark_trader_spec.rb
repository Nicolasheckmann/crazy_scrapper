require './lib/dark_trader'
require 'rspec'
require 'nokogiri'
require 'open-uri'

page_url = "https://coinmarketcap.com/all/views/all/"

page = Nokogiri::HTML(URI.open(page_url))

crypto_name_array = page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
crypto_price_array = page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a')

describe 'the linker methode' do
    it 'creates an Hash with crypto name as key and crypto price as value' do
        expect(linker("BTC","4,4556$")).to eq({"BTC"=>44556.0})
    end
end

describe 'the hash_linker method feeds the linker method and output an array of hashes containing crypto name and prices' do

    it 'is not nil nor empty' do
        expect(hash_linker(crypto_name_array, crypto_price_array)).not_to be_nil
        expect(hash_linker(crypto_name_array, crypto_price_array)).not_to be_empty
    end
    it 'is bigger than 150' do
        expect(hash_linker(crypto_name_array, crypto_price_array).length).to be > 150
    end

    it 'includes Bitcoin, Ethereum and Dogecoin with non empty prices' do
        expect(hash_linker(crypto_name_array, crypto_price_array).map { |h| h.keys }.flatten).to include("BTC", "ETH", "DOGE")
        expect(hash_linker(crypto_name_array, crypto_price_array).map { |h| h.values_at("BTC", "ETH", "DOGE") }.compact).not_to be_empty
        expect(hash_linker(crypto_name_array, crypto_price_array).map { |h| h.values_at("BTC", "ETH", "DOGE") }.compact).not_to be_nil
    end
end