require 'rails_helper'

feature "Customers", type: :feature do
  scenario "Verify link 'Register'" do
    visit(root_path)
    expect(page).to have_link("Register")
  end

  scenario "Verify link 'New Customer'" do
      visit(root_path)
      click_link("Register")
      expect(page).to have_content("Customers")
      expect(page).to have_link("New Customer")
  end

  scenario "Verify New Customer form" do
      visit(customers_path)
      click_on("New Customer")
      expect(page).to have_content("New Customer")
  end

  scenario "Register new customer" do
    visit(new_customer_path)
    customer_name = Faker::Name.name
    fill_in("Name", with: customer_name)
    fill_in("Email", with: Faker::Internet.email)
    fill_in("Phone", with: Faker::PhoneNumber.phone_number)
    attach_file("Photo", Rails.root.join("spec", "fixtures", "files","avatar.jpg"))
    choose(option: ["Yes", "No"].sample)
    click_on("Register")

    expect(page).to have_content("Customer was successfully created")
    expect(Customer.last.name).to eq(customer_name)
  end
end
