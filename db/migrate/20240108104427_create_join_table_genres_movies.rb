class CreateJoinTableGenresMovies < ActiveRecord::Migration[7.1]
  def change
    create_join_table :genres, :movies do |t|
      t.index %i[genre_id movie_id]
      t.index %i[movie_id genre_id]
    end
  end
end
