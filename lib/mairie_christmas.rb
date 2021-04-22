require 'rspec'
require 'pry'
require 'rubocop'
require 'nokogiri'
require 'open-uri'

page_url = "https://www.annuaire-des-mairies.com/val-d-oise.html"

page = Nokogiri::HTML(URI.open(page_url))

townhall_links = page.xpath('//*[@class="lientxt"]')

def get_townhall_email(townhall_url)
    page = Nokogiri::HTML(URI.open(townhall_url))
    townhall_email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    townhall_email.text
end

def get_townhall_url(townhall_links)
    townhall_array = []
    for i in 0..townhall_links.length - 1 do
        puts get_townhall_email("http://annuaire-des-mairies.com" + townhall_links[i]['href'].gsub(/^\./, ''))
        #push un hash composé de {key = nom de la commune => value = email de la commune} dans un array
        townhall_array.push(Hash[townhall_links[i].text => get_townhall_email("http://annuaire-des-mairies.com" + townhall_links[i]['href'].gsub(/^\./, ''))])
    end
    townhall_array
end

puts "#{get_townhall_url(townhall_links)}"