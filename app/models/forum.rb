class Forum < ActiveRecord::Base
  has_many :topics
  has_many :forum_posts, :through => :topics
  validates_presence_of :title, :description, :message => "must not be blank, on penality of defenestration!"
  validates_length_of :description, :minimum => 4
end
