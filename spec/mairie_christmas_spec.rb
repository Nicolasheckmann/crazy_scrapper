require './lib/mairie_christmas'
require 'rspec'

require 'nokogiri'
require 'open-uri'

page_url = "https://www.annuaire-des-mairies.com/val-d-oise.html"

page = Nokogiri::HTML(URI.open(page_url))

townhall_links = page.xpath('//*[@class="lientxt"]')

describe 'the get_townhall_email method' do
    it 'get the email from a given page' do
        expect(get_townhall_email('http://annuaire-des-mairies.com/95/persan.html')).to eq('mairie@ville-persan.fr')
    end
end

describe 'the get_townhall_url method' do

    it 'creates an array of hashes' do
        expect(get_townhall_url(townhall_links)).not_to be_nil
        expect(get_townhall_url(townhall_links)).not_to be_empty
        expect(get_townhall_url(townhall_links).class).to be(Array)
    end
    it 'is of size 185' do
        expect(get_townhall_url(townhall_links).length).to be == 185
    end

    it 'includes AINCOURT, BRIGNANCOURT, CERGY with non empty emails' do
        expect(get_townhall_url(townhall_links).map { |h| h.keys }.flatten).to include("AINCOURT", "BRIGNANCOURT", "CERGY")
        expect(get_townhall_url(townhall_links).map { |h| h.values_at("AINCOURT", "BRIGNANCOURT", "CERGY") }.compact).not_to be_empty
        expect(get_townhall_url(townhall_links).map { |h| h.values_at("AINCOURT", "BRIGNANCOURT", "CERGY") }.compact).not_to be_nil
    end
end