class Movie < ApplicationRecord
  has_many :movie_genres, dependent: :destroy
  has_many :genres, through: :movie_genres

  has_many :movie_watches
  has_many :users, through: :movie_watches

  def self.create_or_update(tmdb_json)
    if Movie.find_by(id: tmdb_json['id'])
      Movie.update(
        tmdb_json['id'],
        popularity: tmdb_json['popularity'],
        vote_count: tmdb_json['vote_count'],
        vote_average: tmdb_json['vote_average']
      )
    else
      Movie.create(tmdb_json)
    end
  end

  def self.create_or_update_many(tmdb_results)
    tmdb_results.each do |tmdb_json|
      Movie.create_or_update(tmdb_json)
    end
  end

end
