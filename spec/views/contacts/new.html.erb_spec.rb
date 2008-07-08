require File.dirname(__FILE__) + "/../../spec_helper"

describe "/contacts/new" do
  it "should render the form" do
    assigns[:contact] = Contact.new
    
    render "/contacts/new.html.erb"
    
    response.should have_tag('form[action=?]','/contact') do
      with_tag('input[name=?]','contact[name]')
      with_tag('input[name=?]','contact[email]')
      with_tag('input[name=?]','contact[phone]')
      with_tag('input[name=?]','contact[message]')
    end
  end
end