require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # Utilizar el método let para definir los usuarios una vez y reutilizarlos en las pruebas
  let(:users) do
    [
      User.create(name: 'Daniel',
                  photo: 'https://media.licdn.com/dms/image/D4E03AQEu5C9mJwO5SQ/profile-displayphoto-shrink_800_800/0/1670102566497?e=1695254400&v=beta&t=uSsO09GTbEpt2btkcNwmkTup_JiVcw-R1oC4Z_JvAhk', bio: 'Lorem ipsum', post_counter: 3),
      User.create(name: 'Jane',
                  photo: 'https://media.istockphoto.com/id/1300972573/photo/pleasant-young-indian-woman-freelancer-consult-client-via-video-call.jpg?s=612x612&w=0&k=20&c=cbjgWR58DgUUETP6a0kpeiKTCxwJydyvXZXPeNTEOxg=', bio: 'Lorem ipsum', post_counter: 5),
      User.create(name: 'John', photo: 'https://www.bu.edu/com/files/2015/08/Groshek_Jacob.jpg', bio: 'Lorem ipsum',
                  post_counter: 2)
    ]
  end

  before do
    users.each(&:save)
  end

  describe 'index page' do
    before { visit users_path }

    it 'shows the list of users' do
      expect(page).to have_content('List of Users')
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

    scenario "click on a user's name to go to their show page" do
      visit users_path
      user = users.first
      click_link user.name

      expect(current_path).to eq(user_path(user))
    end
  end
end
