require 'brewery_db'
require 'firebase'

firebase_uri = 'https://locklear.firebaseio.com/'
@firebase = Firebase::Client.new(firebase_uri)

@brewery_db = BreweryDB::Client.new do |config|
    config.api_key = ''
end

def search_breweries(search_term)
	@hash = Hash.new
	breweries = @brewery_db.search.breweries(q: search_term)
	breweries.each_with_index do |b, index|
		index += 1
		@hash[index] = b.name
		puts index.to_s + "-" + b.name
	end
end

def search_hash(search_term, comment)
	search_term = search_term.downcase
	if search_term == "no"
		puts "thank you for playing"
	else
		response = @firebase.push("favorite_breweries", { 
			:name => @hash[search_term.to_i].to_s,
			:coments => comment })
		if response.success?
			puts @hash[search_term.to_i].to_s + " successfully saved to the database"
		else
			puts "I am sorry an error occured saving to the database"
		end
	end
end

puts "Enter a search term:"
search_term = gets.chomp
search_breweries search_term
puts "******"
puts "Enter the number of the brewery would you like to save or No to quit?"
search_term = gets.chomp
if search_term != 'no'
	puts "If you would like to save a comment about the brewery type it here, otherwise, just press return:"
end
comment = gets.chomp
search_hash(search_term, comment)
# json =  @firebase.get("todos")
# puts json['name'].inspect
# curl 'https://locklear.firebaseio.com/todos.json?print=pretty'
