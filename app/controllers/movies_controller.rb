class MoviesController < ApplicationController

  def index
    queries = ''
    queries += "&primary_release_date.gte=#{params[:minYear]}-01-01" if params[:minYear]
    queries += "&primary_release_date.lte=#{params[:maxYear]}-12-31" if params[:maxYear]
    queries += "&with_genres=#{params[:genres]}" if params[:genres]
    params[:sorter] ? queries += "&sort_by=#{params[:sorter]}" : queries += '&sort_by=popularity.desc'
    params[:sorter] == "vote_average.desc" ? queries += "&vote_count.gte=500" : nil

    movies = get_movies(params[:page], queries)
    
    render json: movies
  end

  def show
    # movie = Movie.find_by(id: params[:id])
    movie = get_movie(params[:id])

    if movie
      movie
    else
      # get_movie(params[:id])
      render json: { error: 'something bad?' }
    end
  end

  def create
    movie = Movie.add_to_database(params[:movie])
  end

  # def credits
  #   movie_credits = Movie.find_by(id: params[:id])

  #   if movie
  #     render json: movie_credits
  #   else
  #     render json: { error: 'something bad happened' }
  #   end
  # end

  def search
    search_url = "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&include_adult=false&page=1"

    search_term = params['search']
    response = JSON.parse(RestClient.get("#{search_url}&query=#{search_term}"))

    if response['total_results'] > 0
      movies = response['results']
      render json: movies
      Movie.create_or_update_many(movies)
    else
      render json: { error: 'no matches found' }
    end
  end

  private

  def get_movies(starting_page = 1, url_queries)
    # first movies_url is for popular movies and second for top rated. Only one can be uncommented
    movies_url = "https://api.themoviedb.org/3/discover/movie?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&include_adult=false&include_video=false&vote_count.gte=200#{url_queries}"

    # movies_url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US"
    response = JSON.parse(RestClient.get(movies_url + "&page=#{starting_page}"))
    Movie.create_or_update_many(response['results'])
  end

  def get_movie(movie_id)
    movie_url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{Rails.application.secrets.tmdb_key}&language=en-US&append_to_response=credits,videos"
    # credits_url = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{Rails.application.secrets.tmdb_key}"
    movie = JSON.parse(RestClient.get(movie_url))
    # credits_response = JSON.parse(RestClient.get(credits_url))
    
    if movie
      render json: movie
    else
      render json: { error: 'nope'}
    end 
  end

end
