require File.dirname(__FILE__) + "/../../spec_helper"

describe "/contacts/new" do
  it "should render the form" do
    assigns[:contact] = Contact.new
    
    render "/contacts/new.html.erb"
    
    response.should have_tag('form[action=?]','/contact/create') do
      with_tag('input[name=?]','contact[name]')
      with_tag('input[name=?]','contact[email]')
      with_tag('input[name=?]','contact[phone]')
      with_tag('input[name=?]','contact[message]')
    end
  end
  
  def expect_error_message_on(attribute)
    template.stub!(:error_message_on)
    assigns[:contact] = Contact.new
    template.should_receive(:error_message_on).with(assigns[:contact], attribute).and_return("message received")
  end
  
  it "should ask for error messages for name" do
    expect_error_message_on(:name)
    
    render "/contacts/new.html.erb"
    
    response.should include_text("message received")
  end
  
  it "should ask for error messages for email" do
    expect_error_message_on(:email)
    
    render "/contacts/new.html.erb"
    
    response.should include_text("message received")
  end
  
  it "should ask for error messages for phone" do
    expect_error_message_on(:phone)
    
    render "/contacts/new.html.erb"
    
    response.should include_text("message received")
  end
  
  it "should ask for error messages for message" do
    expect_error_message_on(:message)
    
    render "/contacts/new.html.erb"
    
    response.should include_text("message received")
  end

end