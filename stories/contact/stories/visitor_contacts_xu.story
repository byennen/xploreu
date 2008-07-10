Story: visitor contacts xu

	As a visitor to xploreu
	I want to contact xploreu
	So that I can tell them how awesome the site is
	
	Scenario: visitor sends message
		Given I am an anonymous visitor
		When I go to the contact form
		And I submit the form with valid data
		Then I should see 'Contact Message Sent'
		