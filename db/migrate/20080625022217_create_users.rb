class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :screen_name, :email
      t.string :password, :limit => 40			
    end
  end

  def self.down
    drop_table :users
  end
end