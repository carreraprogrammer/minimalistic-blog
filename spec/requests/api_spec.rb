require 'swagger_helper'

describe 'Blog API' do
  path '/api/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :string

    get 'List all posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string

      response '200', 'posts found' do
        let(:user_id) { create(:user).id }
        run_test!
      end

      response '404', 'user not found' do
        let(:user_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :string
    parameter name: 'post_id', in: :path, type: :string

    get 'List all comments for a user\'s post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string

      response '200', 'comments found' do
        let(:user_id) { create(:user).id } # Adjust this based on your user setup
        let(:post_id) { create(:post, user_id:).id } # Adjust this based on your post setup
        run_test!
      end

      response '404', 'user or post not found' do
        let(:user_id) { 'invalid' }
        let(:post_id) { 'invalid' }
        run_test!
      end
    end

    post 'Add a comment to a post' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'comment added' do
        let(:user_id) { create(:user).id } # Adjust this based on your user setup
        let(:post_id) { create(:post, user_id:).id } # Adjust this based on your post setup
        let(:comment) { { text: 'A new comment' } }
        run_test!
      end

      response '400', 'invalid comment' do
        let(:user_id) { 'invalid' }
        let(:post_id) { 'invalid' }
        let(:comment) { { text: '' } }
        run_test!
      end
    end
  end
end
