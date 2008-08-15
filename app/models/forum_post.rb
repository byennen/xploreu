class ForumPost < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  validates_presence_of :text
  validates_length_of :text, :minimum => 10
  
  def belongs_to?(other_user)
    user == other_user
  end
end
