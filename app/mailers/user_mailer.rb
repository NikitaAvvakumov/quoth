class UserMailer < ActionMailer::Base
  default from: 'notify@quoth.me'

  def welcome_email(user)
    @user = user
    @url = 'https://pacific-basin-6357-quoth.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to quoth.')
  end
end
