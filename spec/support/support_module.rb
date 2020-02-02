module SupportModule

  def fill_in_update_profile_form(name, email, password = "", confirmation = "")
    fill_in "Name",         with: name
    fill_in "Email",        with: email
    fill_in "Password",     with: password
    fill_in "Confirmation", with: confirmation
  end
  
end