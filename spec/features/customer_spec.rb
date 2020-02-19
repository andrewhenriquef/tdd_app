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
end
