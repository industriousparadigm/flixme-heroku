class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :poster_path
      t.boolean :adult
      t.string :overview
      t.string :release_date
      t.string :title
      t.string :original_title
      t.string :original_language
      t.integer :vote_count
      t.float :vote_average
      t.string :backdrop_path
      t.float :popularity
      t.boolean :video

      t.timestamps
    end
  end
end
