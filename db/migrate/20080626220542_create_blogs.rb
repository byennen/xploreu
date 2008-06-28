class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.integer :user_id
    end
  end

  def self.down
    drop_table :blogs
  end
end