require 'spec_helper'

describe "StaticPages" do

  describe 'Home page' do
    before(:each) { visit '/static_pages/home' }

    it 'it should have the right title' do
      expect(page).to have_title('Quoth')
    end

    it 'it should have content "Quoth"' do
      expect(page).to have_content('Quoth')
    end
  end

  describe 'About page' do
    before(:each) { visit '/static_pages/about' }

    it 'should have the right title' do
      expect(page).to have_title('Quoth | About')
    end

    it 'should have content "About Quoth"' do
      expect(page).to have_content('About Quoth')
    end
  end
end
