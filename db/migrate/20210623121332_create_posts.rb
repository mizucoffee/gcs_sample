class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :body
      t.string :file
      t.timestamps null: false
    end
  end
end
