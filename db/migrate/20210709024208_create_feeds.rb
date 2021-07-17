class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.text :image
      t.text :content
      t.integer :favorite_of_user_id
      t.timestamps
    end
  end
end
