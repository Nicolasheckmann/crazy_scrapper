require 'rspec'
require 'pry'
require 'rubocop'
require 'nokogiri'
require 'open-uri'

page_url = "https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

page = Nokogiri::HTML(URI.open(page_url))

deputy_links = page.xpath('//*[@id="deputes-list"]//li/a')
puts deputy_links

def get_deputy_email(deputy_url)
    page = Nokogiri::HTML(URI.open(deputy_url))
    deputy_email = page.xpath('//*[@id="haut-contenu-page"]//*[contains(text(), "@")]')
    deputy_email.text  
end

def get_deputy_url(deputy_links)
    deputy_array = []
    for i in 0..deputy_links.length - 1 do
        puts get_deputy_email("https://www2.assemblee-nationale.fr" + deputy_links[i]['href'])
        puts deputy_links[i].text.gsub(/M\.|Mme/, '').strip[/\S+/]
        puts deputy_links[i].text.gsub(/M\.|Mme/, '').sub(/\S+/, '').strip
        #push un hash dans un array
        deputy_array.push( Hash[
            'first_name'    => deputy_links[i].text.gsub(/M\.|Mme/, '').strip[/\S+/],
            'last_name'     => deputy_links[i].text.gsub(/M\.|Mme/, '').sub(/\S+/, '').strip,
            'email'         => get_deputy_email("https://www2.assemblee-nationale.fr" + deputy_links[i]['href'])
            ])
    end
    deputy_array
end

puts "#{get_deputy_url(deputy_links)}"