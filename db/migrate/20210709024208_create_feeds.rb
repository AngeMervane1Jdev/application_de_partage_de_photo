class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.text :image
      t.text :content
      t.integer :fovorite_of_user_id, array: true,default:[]
      t.timestamps
    end
  end
end
