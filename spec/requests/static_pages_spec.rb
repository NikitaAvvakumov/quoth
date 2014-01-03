require 'spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for 'all static pages' do
    it { should have_title(full_title(page_title)) }
    it { should have_selector('h1', text: heading) }
  end

  describe 'Home page' do
    before(:each) { visit root_path }
    let(:page_title) { '' }
    let(:heading) { 'Welcome to quoth.' }

    it_should_behave_like 'all static pages'
    it { should_not have_title(' | Home') }
  end

  describe 'About page' do
    before(:each) { visit about_path }
    let(:page_title) { 'About' }
    let(:heading) { 'About quoth.' }

    it_should_behave_like 'all static pages'
  end

  describe 'Privacy page' do
    before(:each) { visit privacy_path }
    let(:page_title) { 'Privacy' }
    let(:heading) { 'quoth privacy policy' }

    it_should_behave_like 'all static pages'
  end

  it 'should have correct links in the layout' do
    visit root_path
    click_link 'About'
    expect(page).to have_title(full_title('About'))
    click_link 'Privacy'
    expect(page).to have_title(full_title('Privacy'))
    click_link 'quoth.'
    expect(page).to have_title(full_title(''))
    click_link 'Sign up'
    expect(page).to have_title(full_title('Sign up'))
  end
end
