Story: visitor contacts xu

	As a visitor to xploreu
	I want to contact xploreu
	So that I can tell them how awesome the site is
	
	Scenario: visitor sends message
		Given I am an anonymous visitor
		When I go to the contact form
		And I submit the form with valid data
		Then I should see 'Contact Message Sent'
		
	Scenario: invalid phone format
		Given I am an anonymous visitor
		When I go to the contact form
		And I enter '123.4567' for Phone
		And I submit the form
		Then I should see 'Phone number is not valid'

	Scenario: missing name
		Given I am an anonymous visitor
		When I go to the contact form
		And I enter '' for Name
		And I submit the form
		Then I should see 'Name is required.'
