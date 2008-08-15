class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.integer :views
      t.references :forum, :user
      t.string :subject
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
