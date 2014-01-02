require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe 'Home page' do
    before(:each) { visit root_path }

    it { should have_title(full_title('')) }
    it { should have_content('Welcome to quoth.') }
    it { should_not have_title('quoth. | Home') }
  end

  describe 'About page' do
    before(:each) { visit about_path }

    it { should have_title(full_title('About')) }
    it { should have_content('About quoth.') }
  end

  describe 'Privacy page' do
    before(:each) { visit privacy_path }

    it { should have_title(full_title('Privacy')) }
    it { should have_content('quoth privacy policy') }
  end
end
