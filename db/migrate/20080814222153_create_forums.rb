class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
    
    add_index :forums, :title
  end

  def self.down
    drop_table :forums
    remove_index :forums, :title
  end
end
