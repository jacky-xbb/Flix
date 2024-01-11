class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :duration
      t.string :director
      t.string :image_file_name
      t.decimal :total_gross
      t.string :rating
      t.date :released_on

      t.timestamps
    end
  end
end
