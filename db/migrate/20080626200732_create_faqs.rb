class CreateFaqs < ActiveRecord::Migration
  def self.up
    create_table :faqs do |t|
      t.integer :user_id, :null => false
      t.text :bio, :skillz, :schools, :companies, :music, :movies, :television, :magazines, :books
    end
  end

  def self.down
    drop_table :faqs
  end
end
