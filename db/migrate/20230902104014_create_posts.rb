class CreatePosts < ActiveRecord::Migration[6.1]
  def change
      create_table :posts do |t|
      t.references :user
      t.string :body
      t.timestamps null: false
      end  
  end
end
