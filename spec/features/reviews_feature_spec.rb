require 'rails_helper'

feature 'reviewing' do
  before {create_and_sign_in_user1}
  before {create_restaurant}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Nandos'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'


    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'allows users to delete a restaurant and its reviews' do
    visit '/restaurants'
    click_link 'Review Nandos'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Delete Nandos'

    expect(page).not_to have_content('so so')
  end

  def create_and_sign_in_user1
    User.create email:'user1@email.com', password:'password'
    visit '/users/sign_in'
    fill_in 'Email', with: 'user1@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  def create_restaurant
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'Nandos'
    click_button 'Create Restaurant'
  end

end
