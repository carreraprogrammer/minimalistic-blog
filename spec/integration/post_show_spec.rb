require 'rails_helper'

RSpec.describe 'Users show page', type: :system do
  include Devise::Test::IntegrationHelpers

  let!(:users) do
    [
      User.create!(name: 'Daniel',
                   photo: 'https://media.licdn.com/dms/image/D4E03AQEu5C9mJwO5SQ/profile-displayphoto-shrink_800' \
                          '800/0/1670102566497?e=1695254400&v=beta&t=uSsO09GTbEpt2btkcNwmkTup_JiVcw-R1oC4Z_JvAhk',
                   email: 'daniel@gmail.com',
                   password: 'password',
                   bio: 'Lorem ipsum', post_counter: 3),
      User.create!(name: 'Jane',
                   photo: 'https://media.licdn.com/dms/image/D4E03AQEu5C9mJwO5SQ/profile-displayphoto-shrink_800' \
                          '/0/1670102566497?e=1695254400&v=beta&t=uSsO09GTbEpt2btkcNwmkTup_JiVcw-R1oC4Z_JvAhk',
                   email: 'Jane@gmail.com',
                   password: 'password',
                   bio: 'Lorem ipsum',
                   post_counter: 5),
      User.create!(name: 'John',
                   photo: 'https://www.bu.edu/com/files/2015/08/Groshek_Jacob.jpg',
                   email: 'Jhon@gmail.com',
                   password: 'password',
                   bio: 'Lorem ipsum',
                   post_counter: 2)
    ]
  end

  let!(:posts) do
    [
      Post.create!(title: 'Post 1', text: 'Lorem ipsum dolor', author: users.first, likes_counter: 10,
                   comments_counter: 5),
      Post.create!(title: 'Post 2', text: 'Lorem ipsum', author: users.first, likes_counter: 5, comments_counter: 0),
      Post.create!(title: 'Post 3', text: 'Lorem ipsum', author: users.first, likes_counter: 7, comments_counter: 2),
      Post.create!(title: 'Post 4', text: 'Lorem ipsum', author: users.first, likes_counter: 2, comments_counter: 1)
    ]
  end

  let!(:comments) do
    [
      Comment.create!(text: 'Lorem ipsum dolor', author: users.first, post: posts.first),
      Comment.create!(text: 'Lorem ipsum', author: users.last, post: posts.first),
      Comment.create!(text: 'Lorem ipsum', author: users.first, post: posts.first),
      Comment.create!(text: 'Lorem ipsum', author: users.last, post: posts.first),
      Comment.create!(text: 'Lorem ipsum', author: users.first, post: posts.first),
      Comment.create!(text: 'Lorem ipsum', author: users.last, post: posts.first)
    ]
  end

  before do
    users.each do |user|
      user.skip_confirmation!
      user.save
    end
    login_as(users.first)
  end

  describe 'GET #show', :focus do
    it 'returns a success response' do
      get user_post_path(users.first, posts.first)
      expect(response).to be_successful
    end

    it 'show\'s the post\'s title' do
      visit user_post_path(users.first, posts.first)
      expect(page).to have_content(posts.first.title)
    end

    it 'show\'s the post\'s author name' do
      visit user_post_path(users.first, posts.first)
      expect(page).to have_content(posts.first.author.name)
    end

    it 'show\'s the number of comments in the post' do
      visit user_post_path(users.first, posts.first)
      expect(page).to have_content(posts.first.comments_counter)
    end

    it 'shows the username of each comment' do
      visit user_post_path(users.first, posts.first)
      comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'shows the text of each comment' do
      visit user_post_path(users.first, posts.first)
      comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'shows the post body' do
      visit user_post_path(users.first, posts.first)
      expect(page).to have_content(posts.first.text)
    end

    it 'show\'s the number of likes in the post' do
      comments.each(&:save)
      visit user_post_path(users.first, posts.first)
      expect(page).to have_content(posts.first.likes_counter)
    end

    it 'have a button to add a new comment' do
      visit user_post_path(users.first, posts.first)
      expect(page).to have_link('Add New Comment')
    end

    it 'have a button to add a new like' do
      visit user_post_path(users.first, posts.first)
      expect(page).to have_button('Like')
    end

    scenario 'click on the add new comment button to go to the new comment page' do
      visit user_post_path(users.first, posts.first)
      click_link 'Add New Comment'
      sleep(0.5)
      expect(current_path).to eq(new_user_post_comment_path(users.first, posts.first))
    end

    scenario 'click on the like button to add a new like' do
      visit user_post_path(users.first, posts.first)
      click_button 'Like'
      sleep(0.5)
      expect do
        posts.first.reload
      end.to change { posts.first.likes_counter }.by(1)
    end
  end
end
