require File.dirname(__FILE__) + '/../spec_helper'

describe Contact do
  it "should assign name" do
    contact = Contact.new(:name => "Lance")
    contact.name.should == 'Lance'
  end

  it "should assign email" do
    contact = Contact.new(:email => "person@site.com")
    contact.email.should == 'person@site.com'
  end

  it "should assign phone" do
    contact = Contact.new(:phone => "555.555.1212")
    contact.phone.should == '555-555-1212'
  end

  it "should assign message" do
    contact = Contact.new(:message => "hey, how come you never call me?")
    contact.message.should == "hey, how come you never call me?"
  end

  it "should not assign non_existent_attribute" do
    lambda {
      Contact.new(:non_existent_attribute => "whatever")
    }.should raise_error(NoMethodError)
  end
  
  it "should have error for missing name" do
    contact = Contact.new
    contact.valid?
    contact.errors.on(:name).should == 'Name is required.'
  end
  
  it "should have error for missing email" do
    contact = Contact.new
    contact.valid?
    contact.errors.on(:email).should == 'Email is not valid.'
  end
  
  it "should have error for missing phome" do
    contact = Contact.new
    contact.valid?
    contact.errors.on(:phone).should =~ /Phone number is not valid/
  end
  
  it "should have error for invalid phome" do
    contact = Contact.new(:phone => 'invalid phone number')
    contact.valid?
    contact.errors.on(:phone).should =~ /Phone number is not valid/
  end
end
