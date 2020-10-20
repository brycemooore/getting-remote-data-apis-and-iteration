require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  people_url = 'http://swapi.dev/api/people/?search=' + character_name.strip
  character = find_character(people_url)
  return get_films(character)
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film
end

def print_movies(films)
  films.each do |film|
    puts film["title"]
  end 
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

def make_request(url)
  #makes request to url and gets back  JSON data
  #returns data as a ruby hash of data
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
  return response_hash
end 

def find_character(url)
  #makes
  person_data = make_request(url)
  return person_data["results"][0] # only returns first matching name
end 

def get_films(character)
  character["films"].map do |film_url|
    make_request(film_url)
  end
end
