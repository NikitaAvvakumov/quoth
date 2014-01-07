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
    end

    describe 'with valid information' do
      before do
        fill_in 'Name', with: 'Sam Vines'
        fill_in 'A short user name', with: 'Captn'
        fill_in 'Email', with: 'vines@nightwatch.am.gov'
        fill_in 'Password', with: 'Sybill'
        fill_in 'Confirm your password', with: 'Sybill'
      end

      it 'should create a new user' do
        expect { click_button 'Sign up for quoth.' }.to change(User, :count).by(1)
      end
    end
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) { visit user_path(user) }

    it { should have_title(user.name) }
    it { should have_selector('h1', "#{user.name}") }
  end
end
