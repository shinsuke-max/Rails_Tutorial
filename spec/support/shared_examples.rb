shared_examples_for "success message" do |msg|
  it { subject.call; expect(flash[:success]).to eq msg }
end

shared_examples_for "error message" do |msg|
  it { subject.call; expect(flash[:danger]).to eq msg }
end

shared_examples_for "redirect to path" do |path|
  it { subject.call; expect(response).to redirect_to path }
end

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