class Message < ActiveRecord::Base
  attr_accessor :subject, :body
  
  validates_presence_of :subject, :body
  validates_length_of :subject, :maximum => DB_STRING_MAX_LENGTH
  validates_length_of :body, :maximum => DB_TEXT_MAX_LENGTH
  
  def initialize(params)
    @subject = params[:subject]
    @body = params[:body]
  end
endclass Message < ActiveRecord::Base
end
