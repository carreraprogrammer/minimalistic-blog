require 'rails_helper'

RSpec.describe 'Post index page', type: :system do
  include Devise::Test::IntegrationHelpers
  let(:users) do
    [
      User.create(name: 'Daniel',
                  photo: 'https://media.licdn.com/dms/image/D4E03AQEu5C9mJwO5SQ/profile-displayphoto-shrink_800' \
                         '800/0/1670102566497?e=1695254400&v=beta&t=uSsO09GTbEpt2btkcNwmkTup_JiVcw-R1oC4Z_JvAhk',
                  email: 'daniel@gmail.com',
                  password: 'password',
                  bio: 'Lorem ipsum', post_counter: 3,
                  role: 'admin'),
      User.create(name: 'Jane',
                  photo: 'https://media.licdn.com/dms/image/D4E03AQEu5C9mJwO5SQ/profile-displayphoto-shrink_800' \
                         '/0/1670102566497?e=1695254400&v=beta&t=uSsO09GTbEpt2btkcNwmkTup_JiVcw-R1oC4Z_JvAhk',
                  email: 'Jane@gmail.com',
                  password: 'password',
                  bio: 'Lorem ipsum',
                  post_counter: 5,
                  role: 'admin'),
      User.create(name: 'John',
                  photo: 'https://www.bu.edu/com/files/2015/08/Groshek_Jacob.jpg',
                  email: 'Jhon@gmail.com',
                  password: 'password',
                  bio: 'Lorem ipsum',
                  post_counter: 2,
                  role: 'admin')
    ]
  end

  let(:posts) do
    [
      Post.create(title: 'Post 1', text: 'Lorem ipsum dolor', author: users.first, likes_counter: 10,
                  comments_counter: 0),
      Post.create(title: 'Post 2', text: 'Lorem ipsum', author: users.first, likes_counter: 5, comments_counter: 3),
      Post.create(title: 'Post 3', text: 'Lorem ipsum', author: users.first, likes_counter: 7, comments_counter: 2),
      Post.create(title: 'Post 4', text: 'Lorem ipsum', author: users.first, likes_counter: 2, comments_counter: 1)
    ]
  end

  let(:comments) do
    [
      Comment.create(text: 'Lorem ipsum dolor', author: users.first, post: posts.first),
      Comment.create(text: 'Lorem ipsum', author: users.last, post: posts.first),
      Comment.create(text: 'Lorem ipsum', author: users.first, post: posts.first),
      Comment.create(text: 'Lorem ipsum', author: users.last, post: posts.first),
      Comment.create(text: 'Lorem ipsum', author: users.first, post: posts.first),
      Comment.create(text: 'Lorem ipsum', author: users.last, post: posts.first)
    ]
  end

  before do
    users.each do |user|
      user.skip_confirmation!
      user.save
    end
    login_as(users.first)
    posts.each(&:save)
    comments.each(&:save)
  end

  describe 'GET #index' do
    let(:user) { users.first }

    it 'returns a success response' do
      get user_posts_path(user)
      expect(response).to be_successful
    end

    it 'shows the user\'s profile picture.' do
      visit user_posts_path(user)
      expect(page).to have_css("img[src*='#{user.photo}']")
    end

    it 'shows the user\'s name.' do
      visit user_posts_path(user)
      expect(page).to have_content(user.name)
    end

    it 'shows the number of posts the user has.' do
      visit user_posts_path(user)
      expect(page).to have_content(user.post_counter)
    end

    it 'shows the post\'s title.' do
      visit user_posts_path(user)
      posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'shows the post\'s text.' do
      visit user_posts_path(user)
      posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'shows only the first 5 comments on a post.' do
      visit user_posts_path(user)
      post_comments = comments.sort_by(&:created_at).first(5)
      post_comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'shows the number of likes a post has.' do
      visit user_posts_path(user)
      posts.each do |post|
        expect(page).to have_content(post.likes_counter)
      end
    end

    it 'shows the number of comments a post has.' do
      visit user_posts_path(user)
      posts.each do |post|
        expect(page).to have_content(post.comments_counter)
      end
    end

    it 'shows the pagination button' do
      visit user_posts_path(user)
      expect(page).to have_button('Pagination')
    end

    scenario 'click on a post\'s title to go to its show page' do
      visit user_posts_path(user)
      post = posts.second
      click_on post.title
      sleep(0.5)
      expect(current_path).to eq(user_post_path(user.id, post.id))
    end
  end
end
