class CreateMovieWatches < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_watches do |t|
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
