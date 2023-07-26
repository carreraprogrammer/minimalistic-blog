require 'rails_helper'

RSpec.describe 'Users show page', type: :system do
  let(:users) do
    [
      User.create(name: 'Daniel',
                  photo: 'https://media.licdn.com/dms/image/D4E03AQEu5C9mJwO5SQ/profile-displayphoto-shrink_800' \
                         '800/0/1670102566497?e=1695254400&v=beta&t=uSsO09GTbEpt2btkcNwmkTup_JiVcw-R1oC4Z_JvAhk',
                  bio: 'Lorem ipsum', post_counter: 3),
      User.create(name: 'Jane',
                  photo: 'https://media.licdn.com/dms/image/D4E03AQEu5C9mJwO5SQ/profile-displayphoto-shrink_800' \
                         '/0/1670102566497?e=1695254400&v=beta&t=uSsO09GTbEpt2btkcNwmkTup_JiVcw-R1oC4Z_JvAhk',
                  bio: 'Lorem ipsum',
                  post_counter: 5),
      User.create(name: 'John',
                  photo: 'https://www.bu.edu/com/files/2015/08/Groshek_Jacob.jpg',
                  bio: 'Lorem ipsum',
                  post_counter: 2)
    ]
  end

  let(:posts) do
    [
      Post.create(title: 'Post 1', text: 'Lorem ipsum dolor', author: users.first, likes_counter: 10,
                  comments_counter: 5),
      Post.create(title: 'Post 2', text: 'Lorem ipsum', author: users.first, likes_counter: 5, comments_counter: 0),
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

  describe 'GET #show', :focus do
    it 'returns a success response' do
      get user_post_path(users.first, posts.first)
      expect(response).to be_successful
    end

    it 'show\'s the post\'s author name' do
      visit user_post_path(users.first, posts.first)
      expect(page).to have_content(posts.first.author.name)
    end

    it 'show\'s the number of comments in the post' do
      visit user_post_path(users.first, posts.first)
      expect(page).to have_content(posts.first.comments_counter)
    end

    it 'show\'s the number of likes in the post' do
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

      expect(current_path).to eq(new_user_post_comment_path(users.first, posts.first))
    end

    scenario 'click on the like button to add a new like' do
      visit user_post_path(users.first, posts.first)
      click_button 'Like'

      expect do
        posts.first.reload
      end.to change { posts.first.likes_counter }.by(1)
    end

    scenario 'the same user click the like button twice' do
      visit user_post_path(users.first, posts.first)
      click_button 'Like'
      click_button 'Like'

      expect do
        posts.first.reload
      end.to change { posts.first.likes_counter }.by(1)
    end
  end
end
