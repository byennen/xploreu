class CreateSpecs < ActiveRecord::Migration
  def self.up
    create_table :specs do |t|
      t.integer :user_id, :null => false
      t.string :first_name, :last_name, :gender, :default => ""
      t.date :birthdate
      t.string :occupation, :city, :state, :zip_code, :default => ""
      t.timestamps
    end
  end

  def self.down
    drop_table :specs
  end
end
