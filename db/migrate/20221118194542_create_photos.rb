class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :image
      t.integer :comments_count
      t.integer :likes_count
      t.text :caption
      # t.references :owner, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :users}, index: true

      t.timestamps
    end
  end
end
