class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :forum_posts
  validates_presence_of :subject
  validates_length_of :subject, :minimum => 4
  validates_associated :forum_posts
  
  def belongs_to?(other_user)
    user == other_user
  end
end
