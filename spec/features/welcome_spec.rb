require 'rails_helper'

RSpec.feature "Welcomes", type: :feature do
  scenario 'Show welcome message' do
    visit root_path

    expect(page).to have_content('Welcome')
  end

  scenario 'Validate if clients registration link exists on page' do
    visit root_path
    expect(find('ul li')).to have_link('Clients registration')
  end
end
