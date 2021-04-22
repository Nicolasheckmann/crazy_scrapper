require './lib/dear_deputy'
require 'rspec'

require 'nokogiri'
require 'open-uri'

page_url = "https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

page = Nokogiri::HTML(URI.open(page_url))

deputy_links = page.xpath('//*[@id="deputes-list"]//li/a')

describe 'the get_deputy_email method' do
    it 'get the email from a given page' do
        expect(get_deputy_email('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA721674')).to eq('Stephanie.Atger@assemblee-nationale.fr')
    end
end

describe 'the get_deputy_url method' do

    it 'creates an array of hashes' do
        expect(get_deputy_url(deputy_links)).not_to be_nil
        expect(get_deputy_url(deputy_links)).not_to be_empty
        expect(get_deputy_url(deputy_links).class).to be(Array)
    end
    it 'is of size 577' do
        expect(get_deputy_url(deputy_links).length).to be == 577
    end

    it 'has non empty or nil values at first_name last_name and email' do
        expect(get_deputy_url(deputy_links).map { |h| h.values_at("first_name", "last_name", "email") }.compact).not_to be_empty
        expect(get_deputy_url(deputy_links).map { |h| h.values_at("first_name", "last_name", "email") }.compact).not_to be_nil
    end
end