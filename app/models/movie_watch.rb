class MovieWatch < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates_uniqueness_of :movie_id, scope: [:movie_id, :user_id]

  def self.create_or_update(user_id, movie_id, rating = nil)
    movie_watch = MovieWatch.find_by(user_id: user_id, movie_id: movie_id)
    if movie_watch
      movie_watch.update(rating: rating)
    else
      MovieWatch.create(user_id: user_id, movie_id: movie_id, rating: rating)
    end
  end

end