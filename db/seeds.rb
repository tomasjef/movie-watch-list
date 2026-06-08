require 'open-uri'
require 'json'

PAGES_TO_FETCH = 5

puts "Fetching movies..."
(1..PAGES_TO_FETCH).each do |page|
  url = "https://tmdb.lewagon.com/movie/top_rated?page=#{page}"
  movies_serialized = URI.open(url).read
  movies = JSON.parse(movies_serialized)

  puts "Creating movies from page #{page}..."
  movies['results'].each do |movie|
    Movie.find_or_create_by!(title: movie['title']) do |m|
      m.overview = movie['overview']
      m.poster_url = "https://image.tmdb.org/t/p/w500#{movie['poster_path']}"
      m.rating = movie['vote_average']
    end
  end
end
puts "Finished!"
