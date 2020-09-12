require "rails_helper"

RSpec.describe "User Registration", type: :feature do
  describe "As a visitor" do
    it "can login" do
      user = User.create(email: "funbucket13@gmail.com", password: "test", name: "Mike Dao", role: 1)

      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_on "Login to Account"
      expect(current_path).to eq("/merchant") #this need to be updated to meet us13 requirements
    end

    it "cannot log in with bad credentials" do
      user = User.create(email: "funbucket13@gmail.com", password: "test", name: "Mike Dao", role: 1)

      visit "/"
      click_on "Login"

      fill_in :email, with: user.email
      fill_in :password, with: "incorrect password"

      click_on "Login to Account"

      expect(current_path).to eq('/login')
      expect(page).to have_content("Sorry, your credentials are bad.")
    end
  end
end
