include ApplicationHelper

def valid_signin(user)
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def valid_signup(user)
  fill_in 'Name', with: user.name
  fill_in 'A short user name', with: user.username
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  fill_in 'Confirm your password', with: user.password
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_signout_link do
  match do |page|
    expect(page).to have_link('Sign out', href: signout_path)
  end
end

RSpec::Matchers.define :have_signin_link do
  match do |page|
    expect(page).to have_link('Sign in', href: signin_path)
  end
end

RSpec::Matchers.define :have_correct_heading do |heading|
  match do |page|
    expect(page).to have_selector('h1', text: heading)
  end
end
