require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario 'Verify client registration' do
    visit root_path
    expect(find('ul li')).to have_link('Clients registration')
  end

  scenario 'Verify new client link' do
    visit root_path
    click_on 'Clients registration'

    expect(page).to have_content 'Listando Clientes'
    expect(page).to have_link 'New Client'
  end

  scenario 'verify new client form' do
    visit customers_path

    click_on 'New Client'
    expect(page).to have_content('New Client Registration')
  end

  # happy path
  scenario 'Register a valid client' do
    visit new_customer_path
    customer_name = Faker::Name.name

    fill_in 'Name', with: customer_name
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Phone', with: Faker::PhoneNumber.phone_number
    attach_file 'Avatar', "#{Rails.root}/spec/fixtures/avatar.png"
    choose(option: ['Y', 'N'].sample)
    click_on 'Create Client'

    expect(page).to have_content('Client succesfully registered')
    expect(Customer.last.name).to eq(customer_name)
  end

  # sad path
  scenario 'Register a invalid client' do
    visit new_customer_path

    click_on 'Create Client'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
  end

  scenario 'Shows a client' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoker: ['Y', 'N'].sample
    )

    visit customer_path(customer)

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
    expect(page).to have_content(customer.avatar)
    expect(page).to have_content(customer.smoker)
  end

  scenario 'Shows all clients' do
    customer1 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoker: ['Y', 'N'].sample
    )

    customer2 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoker: ['Y', 'N'].sample
    )

    visit customers_path

    expect(page).to have_content(customer1.name)
    expect(page).to have_content(customer1.email)
    expect(page).to have_content(customer1.phone)
    expect(page).to have_content(customer1.avatar)
    expect(page).to have_content(customer1.smoker)

    expect(page).to have_content(customer2.name)
    expect(page).to have_content(customer2.email)
    expect(page).to have_content(customer2.phone)
    expect(page).to have_content(customer2.avatar)
    expect(page).to have_content(customer2.smoker)
  end

  # happy path
  scenario 'Updates a valid Client' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoker: ['Y', 'N'].sample
    )

    new_name = Faker::Name.name
    visit edit_customer_path(customer)

    fill_in 'Name', with: new_name

    click_on 'Save Client'

    expect(page).to have_content('Client succesfully updated')
  end

  # sad path
  scenario 'Updates a invalid Client' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoker: ['Y', 'N'].sample
    )

    new_name = Faker::Name.name
    visit edit_customer_path(customer)

    fill_in 'Name', with: ''
    fill_in 'Email', with: ''

    click_on 'Save Client'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
  end
end
