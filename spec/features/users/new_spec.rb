require "rails_helper"

RSpec.describe "User Registration", type: :feature do
  describe "As a visitor" do
    it "can create new user" do

      visit '/items'

      within '.topnav' do
        click_link "Register"
      end

      expect(current_path).to eq('/register')
      save_and_open_page

      fill_in :name, with: "Captain Jack"
      fill_in :street_address, with: "123 Main Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "11111"
      fill_in :email, with: "c_j@email.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_on "submit"
      expect(current_path).to eq('/profile')
      expect(page).to have_content('You are now registered and logged in!')
    end
  end
end