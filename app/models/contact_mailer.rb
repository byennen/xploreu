class ContactMailer < ActionMailer::Base
  def contact(contact)
    from contact.email
    subject "XploreU Contact"
    body :contact => contact
    recipients CONTACT_EMAIL
  end
end
