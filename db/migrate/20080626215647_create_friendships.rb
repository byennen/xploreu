class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.integer  :user_id
      t.integer  :friend_id
      t.string   :status
      t.column :created_at, :datetime
      t.column :accepted_at, :datetime
    end
  end

  def self.down
    drop_table :friendships
  end
end
