class UserMailer < ActionMailer::Base
  
  def reminder(user)
    @subject      = 'Your login information at XploreU.com'
    @body         = {}
    # Give body access to the user information.
    @body["user"] = user
    @recipients   = user.email
    @from         = 'XploreU <do-not-reply@railsspace.com>'
  end
  
  def message(mail)
    subject     mail[:message].subject
    from        'XploreU <do-not-reply@railsspace.com>'
    recipients  mail[:recipient].email
    body        mail
  end

  def friend_request(mail)
    subject     'New friend request at XploreU.com'
    from        'XploreU <do-not-reply@railsspace.com>'
    recipients  mail[:friend].email
    body        mail
  end
end