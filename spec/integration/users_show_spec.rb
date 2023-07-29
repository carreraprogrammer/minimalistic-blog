require 'rails_helper'

RSpec.describe 'Users show page', type: :system do
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

  describe 'show page' do
    let(:user) { users.first }
    let(:posts) do
      [
        Post.create(title: 'Post 1', text: 'Lorem ipsum dolor', author: user, likes_counter: 10, comments_counter: 5),
        Post.create(title: 'Post 2', text: 'Lorem ipsum', author: user, likes_counter: 5, comments_counter: 3),
        Post.create(title: 'Post 3', text: 'Lorem ipsum', author: user, likes_counter: 7, comments_counter: 2),
        Post.create(title: 'Post 4', text: 'Lorem ipsum', author: user, likes_counter: 2, comments_counter: 1)
      ]
    end

    before do
      posts.each(&:save)
      visit user_path(user)
    end

    it "display's the user#show page" do
      expect(current_path).to eq(user_path(user))
    end

    it 'shows the user name' do
      expect(page).to have_content(user.name)
    end

    it 'shows the user bio' do
      expect(page).to have_content(user.bio)
    end

    it 'shows the number of posts the user has written' do
      expect(page).to have_content(user.post_counter)
    end

    it 'shows the user photo' do
      expect(page).to have_css("img[src*='#{user.photo}']")
    end

    it 'shows the "Create New Post" link' do
      expect(page).to have_link('Create New Post')
    end

    it 'shows the title of the three most recent posts' do
      recent_posts = posts.sort_by(&:created_at).last(3)
      recent_posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'shows the text of the three most recent posts' do
      recent_posts = posts.sort_by(&:created_at).last(3)
      recent_posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'shows the number of likes of the three most recent posts' do
      recent_posts = posts.sort_by(&:created_at).last(3)
      recent_posts.each do |post|
        expect(page).to have_content(post.likes_counter)
      end
    end

    it 'shows the number of comments of the three most recent posts' do
      recent_posts = posts.sort_by(&:created_at).last(3)
      recent_posts.each do |post|
        expect(page).to have_content(post.comments_counter)
      end
    end

    it 'shows a button that lets me view all of a user\'s posts ' do
      expect(page).to have_link("See All People's Posts")
    end

    scenario 'When I click a user\'s post, it redirects me to that post\'s show page.' do
      post = posts.last
      user = users.first
      click_on post.title
      expect(current_path).to eq(user_post_path(user.id, post.id))
    end

    scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
      click_on "See All People's Posts"
      expect(current_path).to eq(user_posts_path(user.id))
    end
  end
end
