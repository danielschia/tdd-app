require 'rails_helper'

feature "Customers", type: :feature do
  scenario "Verify link 'Register'" do
    visit(root_path)
    expect(page).to have_link("Register")
  end

  scenario "Verify link 'New Customer'" do
      visit(root_path)
      click_link("Register")
      expect(page).to have_content("Lista de Clientes")
      expect(page).to have_link("Novo Cliente")
  end

  scenario "Verify New Customer form" do
      visit(customers_path)
      click_on("Novo Cliente")
      expect(page).to have_content("Novo Cliente")
  end

  scenario "Register new customer (Happy Path)" do
    visit(new_customer_path)
    customer_name = Faker::Name.name
    fill_in("Nome", with: customer_name)
    fill_in("Email", with: Faker::Internet.email)
    fill_in("Telefone", with: Faker::PhoneNumber.phone_number)
    attach_file("Foto do Perfil", Rails.root.join("spec", "fixtures", "files","avatar.jpeg"))
    choose(option: [true, false].sample)
    click_on("Criar Cliente")

    expect(page).to have_content("Cliente cadastrado com sucesso")
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario "Register new customer without any field" do
    visit(new_customer_path)
    click_on("Criar Cliente")
    expect(page).to have_content("não pode ficar em branco")
  end
end
