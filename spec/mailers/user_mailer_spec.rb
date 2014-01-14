require "spec_helper"

describe UserMailer do

  describe 'welcome email' do
    let(:user) { User.create(name: 'Sam Vines', username: 'Captn', email: 'vines@nightwatch.am.gov',
                                    password: 'Sybill', password_confirmation: 'Sybill') }
    let(:mail) { UserMailer.welcome_email(user) }

    it 'should have correct subject' do
      expect(mail.subject).to eq 'Welcome to quoth.'
    end

    it 'should have correct from: address' do
      expect(mail.from).to eq ['notify@quoth.me']
    end

    it 'should have correct to: address' do
      expect(mail.to).to eq [user.email]
    end

    it "should have new user's name in the heading" do
      expect(mail.body.encoded).to have_selector('h1', user.name)
    end

    it "should have new user's username in the body" do
      expect(mail.body.encoded).to have_content(user.username)
    end

    it 'should have confirmation link' do
      # to be updated when confirmation links are implemented
      # replace 'root_url' with e.g. 'http://#{root_url}/#{user.id}/confirmation'
      expect(mail.body.encoded).to have_link(root_url)
    end
  end
end
