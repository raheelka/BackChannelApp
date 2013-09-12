class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :weight
      t.integer :user_id

      t.timestamps
    end
  end
end
