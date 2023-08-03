require 'rails_helper'

RSpec.describe 'Users index page', type: :system do
  include Devise::Test::IntegrationHelpers
  let(:users) do
    [
      User.create(name: 'Daniel',
                  photo: 'https://media.licdn.com/dms/image/D4E03AQEu5C9mJwO5SQ/profile-displayphoto-shrink_800' \
                         '800/0/1670102566497?e=1695254400&v=beta&t=uSsO09GTbEpt2btkcNwmkTup_JiVcw-R1oC4Z_JvAhk',
                  email: 'daniel@gmail.com',
                  password: 'password',
                  bio: 'Lorem ipsum', post_counter: 3),
      User.create(name: 'Jane',
                  photo: 'https://media.licdn.com/dms/image/D4E03AQEu5C9mJwO5SQ/profile-displayphoto-shrink_800' \
                         '/0/1670102566497?e=1695254400&v=beta&t=uSsO09GTbEpt2btkcNwmkTup_JiVcw-R1oC4Z_JvAhk',
                  email: 'Jane@gmail.com',
                  password: 'password',
                  bio: 'Lorem ipsum',
                  post_counter: 5),
      User.create(name: 'John',
                  photo: 'https://www.bu.edu/com/files/2015/08/Groshek_Jacob.jpg',
                  email: 'Jhon@gmail.com',
                  password: 'password',
                  bio: 'Lorem ipsum',
                  post_counter: 2)
    ]
  end

  before do
    users.each do |user|
      user.skip_confirmation!
      user.save
    end
    login_as(users.first)
  end

  describe 'index page' do
    before do
      visit users_path
    end

    it 'shows the user name of signed user' do
      expect(page).to have_content(users.first.name)
    end

    it 'shows the user name of all users' do
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'shows the user photo of all users' do
      users.each do |user|
        expect(page).to have_css("img[src*='#{user.photo}']")
      end
    end

    it 'shows the number of posts of each user' do
      users.each do |user|
        expect(page).to have_content(user.post_counter)
      end
    end

    scenario "click on a user's name to go to their show page" do
      sign_in(users.first)
      visit users_path
      click_on users.first.name
      sleep(0.5)
      expect(current_path).to eq(user_path(users.first))
    end
  end
end
