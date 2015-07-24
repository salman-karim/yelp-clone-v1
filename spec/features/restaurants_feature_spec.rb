require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Nandos')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Nandos')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do

    before {create_and_sign_in_user1}

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Nandos'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Nandos'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do
    let!(:nandos){Restaurant.create(name:'Nandos')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Nandos'
      expect(page).to have_content 'Nandos'
      expect(current_path).to eq "/restaurants/#{nandos.id}"
    end
  end

  context 'editing restaurants' do
    before {create_and_sign_in_user1}
    before {create_restaurant}

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Nandos'
      fill_in 'Name', with: 'Nandos awesome chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Nandos awesome chicken'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'cannot edit a restaurant they did not create' do
      visit '/restaurants'
      click_link 'Sign out'
      create_and_sign_in_user2
      click_link 'Edit Nandos'
      expect(page).not_to have_content 'Update Restaurant'
    end

  end

  context 'deleting restaurants' do

    before {create_and_sign_in_user1}
    before {create_restaurant}

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Nandos'
      expect(page).not_to have_content 'Nandos'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'cannot delete a restaurant they did not create' do
      visit '/restaurants'
      click_link 'Sign out'
      create_and_sign_in_user2
      click_link 'Delete Nandos'
      expect(page).to have_content "User must be associated with restaurant"
    end

  end

  context 'an invalid restaurants' do

    before {create_and_sign_in_user1}

    it 'does not let you submit a name that is too short' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
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

def create_and_sign_in_user2
  User.create email:'user2@email.com', password:'password'
  visit '/users/sign_in'
  fill_in 'Email', with: 'user2@email.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end


end
