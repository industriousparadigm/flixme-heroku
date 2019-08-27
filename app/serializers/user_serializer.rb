class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :last_name, :email, :avatar_url, :friends, :movies
  # has_many :friends
  has_many :movies

  def name
    "#{object.first_name} #{object.last_name}"
  end

  def movies
    object.movies.map do |movie|
      movie_watch = MovieWatch.find_by(user: object, movie: movie)
      rated_movie = movie.as_json
      rated_movie.merge!(user_rating: movie_watch.rating, rating_date: movie_watch.updated_at)
    end.sort_by { |movie| movie[:rating_date] }.reverse
  end

end