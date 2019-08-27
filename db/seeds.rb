genres_url = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US"
movies_url = "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&sort_by=popularity.desc&include_video=false"

search_url = "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&page=1"
#&query=


# &page=

# fetch the genres
response = JSON.parse(RestClient.get(genres_url))
response['genres'].each do |genre|
  Genre.find_or_create_by(genre)
end

# fetch a shitload of movies. Let's say 1000 pages worth of movies. 40 requests 25 times @ 11s each = 275s or ~5min
# page = 1
# 25.times do
#   40.times do
#     response = JSON.parse(RestClient.get(movies_url + "&page=#{page}"))

#     response["results"].each do |movie_json|
#       Movie.add_to_database(movie_json)
#     end
#     page += 1
#   end
#   sleep 11
# end

