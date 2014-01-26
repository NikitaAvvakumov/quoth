require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe 'signin page' do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title(full_title('Sign in')) }
  end

  describe 'signin' do
    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign in' }

      it { should have_title(full_title('Sign in')) }
      it { should have_error_message('Invalid email/password') } # custom matcher in spec/support/utilities.rb

      describe 'after going to another page' do
        before { click_link 'quoth.' }
        it { should_not have_error_message('Invalid email/password') }
      end
    end

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        visit signin_path
        valid_signin(user) # helper method in spec/support/utilities.rb
      end

      it { should have_title(full_title(user.name)) }
      it { should_not have_signin_link} # custom matcher in spec/support/utilities.rb
      it { should have_signout_link } # custom matcher in spec/support/utilities.rb

      describe 'followed by signing out' do
        before { click_link 'Sign out' }
        it { should have_signin_link }
      end
    end
  end
end
