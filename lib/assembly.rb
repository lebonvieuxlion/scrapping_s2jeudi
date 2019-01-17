require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'


def get_deputy_email (url)

page = Nokogiri::HTML(open(url))						#on met l'url en tant que variable afin d'éviter un message d'erreur avec la constante PAGE_URL

email_deputy = page.css('#deputes-contact dl > dd:nth-child(3) a') 					#on sélecte en utilisant css

array_email =  email_deputy.map { |link| link['href'].delete_prefix("mailto:") }

return array_email[0]

end





PAGE_URL = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"


def get_url_deputy

	url_storage = []								#crée un array vide où entreproser les url des villes que l'on scrappe

	page = Nokogiri::HTML(open(PAGE_URL))			#va chercher la page que l'on veut scrapper

	url = page.css("#deputes-list ul li a")

	url.each do |url_page|

		url_storage << "http://www2.assemblee-nationale.fr" + url_page['href']

	end

	return	url_storage				
												
end



def get_deputy_firstname(url)

page = Nokogiri::HTML(open(url))						#on met l'url en tant que variable afin d'éviter un message d'erreur avec la constante PAGE_URL

firstname_deputy = page.css('.titre-bandeau-bleu > h1:nth-child(1)').text	

firstname_deputy = firstname_deputy.split(" ")
firstname_deputy[1]


end


def get_deputy_secondname(url)

	page = Nokogiri::HTML(open(url))						#on met l'url en tant que variable afin d'éviter un message d'erreur avec la constante PAGE_URL

	secondname_deputy = page.css('.titre-bandeau-bleu > h1:nth-child(1)').text	

	secondname_deputy = secondname_deputy.split(" ")

	if secondname_deputy.length > 3							

		return secondname_deputy[2..3].join(" ")					

	else
			return secondname_deputy[2]
	end


end

def create_hash_deputy

	deputy_hash = {}

	get_url_deputy.each do |url|

		deputy_hash [:first_name] = get_deputy_firstname(url)
		deputy_hash[:second_name] = get_deputy_secondname(url)
		deputy_hash [:email] = get_deputy_email(url)
	end

	return deputy_hash


end


puts create_hash_deputy