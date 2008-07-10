steps_for(:visitor_contacts_xu) do

	Given "I am an anonymous visitor" do
	  # no-op
  end
  
	When "I go to the contact form" do
	  visits "/contact"
    # puts response.body
  end
  
	When "I submit the form with valid data" do
	  fills_in 'Name', :with => 'Lance'
    fills_in 'Email', :with => 'lance@whatever.com'
    fills_in 'Phone', :with => '555-555-1212'
	  clicks_button "Submit"
  end
  
  When "I enter '$data' for $field" do |data, field|
    fills_in field, :with => data
  end
  
  When "I submit the form" do
	  clicks_button "Submit"
  end
  
	Then /I should see '(.*)'/ do |text|
	  response.should include_text(text)
  end

end
