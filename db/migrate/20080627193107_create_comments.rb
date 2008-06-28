class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :body
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :comments
  end
end
