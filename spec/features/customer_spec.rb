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

  scenario "Show a customer" do
    customer = create (:customer)
    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
  end

  scenario "Test index page" do
    customer1 = create (:customer)
    customer2 = create (:customer)

    visit(customers_path)
    expect(page).to have_content(customer1.name) 
    expect(page).to have_content(customer2.name)
  end

  scenario "Test update customer" do
    customer1 = create (:customer)

    new_name = Faker::Name.name
    visit(edit_customer_path(customer1.id))
    fill_in("Nome", with: new_name)
    click_on("Atualizar Cliente")
    expect(page).to have_content("Cliente atualizado com sucesso")
    expect(page).to have_content(new_name)
  end

  scenario "Test show link in index" do
    customer1 = create (:customer)
    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[2]/a").click
    expect(page).to have_content("Mostrando Cliente")
  end

  scenario "Test edit link in index" do
    customer1 = create (:customer)
    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[3]/a").click
    expect(page).to have_content("Editar Cliente")
  end

  scenario "Test delete link in index", js: true do
    customer1 = create (:customer)
    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr[1]/td[4]/a").click
    1.second
    page.driver.browser.switch_to.alert.accept
    
    expect(page).to have_content("Cliente excluído com sucesso")
  end
end
