require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"


def scrap_currency_name

page = Nokogiri::HTML(open(PAGE_URL))


	@array_name_currency = []										#on crée un array pour entreposer nos données

	name_currency = page.css('td[class="text-left col-symbol"]')	#on va chercher l'élément css. Il renvoie un élément node sur lequel on ne peut itérer
																	#qu'avec each

	name_currency = name_currency.each do |currency|				#on itère sur chacun des éléments en ajoutant le texte de l'élément sélectionné 
		@array_name_currency << currency.text        				#dans le array créé auparavant
	end

end




def scrap_currency_value

	page = Nokogiri::HTML(open(PAGE_URL))

	@array_value_currency = []										#même système sauf qu'on va chercher l'élément avec les prix

	value_currency = page.css('a[class="price"]')

	value_currency = value_currency.each do |currency| 

		@array_value_currency << currency.text

	end

end





def get_currency_name_and_value	

	scrap_currency_name
	scrap_currency_value													

	my_hash = Hash[@array_name_currency.zip @array_value_currency]		#on crée le hash avec les deuc array et la méthode zip

	my_hash = my_hash.transform_values {|v| v.gsub('$', '') }			#on retire aux valeur le dollar pour rendre des données utilisables
	
	return my_hash

end



puts get_currency_name_and_value.has_key?("BTC")