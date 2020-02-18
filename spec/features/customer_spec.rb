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
end
