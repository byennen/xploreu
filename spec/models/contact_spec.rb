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
end
