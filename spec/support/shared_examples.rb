shared_examples_for "signup-form have right css" do
  it { expect(page).to have_css('label', text: 'Name') }
  it { expect(page).to have_css('label', text: 'Email') }
  it { expect(page).to have_css('label', text: 'Password') }
  it { expect(page).to have_css('label', text: 'Confirmation') }
  it { expect(page).to have_css('input#user_name') }
  it { expect(page).to have_css('input#user_email') }
  it { expect(page).to have_css('input#user_password') }
  it { expect(page).to have_css('input#user_password_confirmation') }
  it { expect(page).to have_button('Create my account') }
end