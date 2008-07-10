class Contact
  # self is the class
  include Validatable
 
  attr_accessor :name, :email, :phone, :message
 
  validates_presence_of :name, :message => "Name is required."
  validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
    :message => "Email is not valid."
  validates_format_of :phone, :with => /^[0-9]{3,3}-[0-9]{3,3}-[0-9]{4,4}$/,
    :message => "Phone number is not valid (xxx-xxx-xxxx)."
  validates_presence_of :message, :message => "Name is required."
  
  class << self
    alias_method :new_without_params, :new
    def new params ={}
      returning new_without_params do |contact|
        params.each_pair do |key,value|
          contact.send "#{key}=", value
        end
      end
    end
  end
 
  def phone=(phone)
    # self is the object
    @phone = phone.gsub(/[^0-9]/, "").gsub(/^([0-9]{0,3})([0-9]{0,3})([0-9]{0,})$/) do |match|
      tmp = ""
      tmp += $1 if $1.size > 0
      tmp += "-" + $2 if $2.size > 0
      tmp += "-" + $3 if $3.size > 0
      tmp
    end
  end  
 
  def deliver
    if valid?
      ContactMailer.deliver_contact(self)
    else
      false
    end
  end
end