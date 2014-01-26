require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe 'signup page' do
    before(:each) { visit signup_path }

    it { should have_title(full_title('Sign up')) }
    it { should have_content('Sign up for quoth.') }

    describe 'with invalid information' do
      it 'should not create a new user' do
        expect { click_button 'Sign up for quoth.' }.not_to change(User, :count)
      end

      describe 'after submission' do
        before { click_button 'Sign up for quoth.' }
        it { should have_title(full_title('Sign up')) }
        it { should have_error_message('error') } # custom matcher in spec/support/utilities.rb
      end
    end

    describe 'with valid information' do
      let(:new_user) { FactoryGirl.build(:user) }
      before { valid_signup(new_user) } # helper method in spec/support/utilities.rb

      describe 'user creation' do
        it 'should create a new user' do
          expect { click_button 'Sign up for quoth.' }.to change(User, :count).by(1)
        end

        describe 'welcome email' do
          let(:last_email) { ActionMailer::Base.deliveries.last }

          it 'should send a welcome email to new user' do
            expect(last_email.to).to eq [new_user.email]
            expect(last_email.subject).to eq 'Welcome to quoth.'
          end
        end
      end

      describe 'after submission' do
        before { click_button 'Sign up for quoth.' }
        let(:found_user) { User.find_by(email: new_user.email) }

        it { should have_title(full_title(new_user.name)) }
        it { should have_success_message('Welcome to quoth.') }
        it { should have_signout_link }
      end
    end
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) { visit user_path(user) }

    it { should have_title(user.name) }
    it { should have_correct_heading("#{user.name}") }
  end
end
