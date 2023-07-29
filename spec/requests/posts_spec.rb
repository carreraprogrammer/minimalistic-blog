require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  include Devise::Test::IntegrationHelpers
  subject do
    User.new(name: 'Daniel', photo: 'photo.png', bio: 'Lorem ipsum', post_counter: 3, email: 'daniel@gmail.com',
             password: 'password')
  end

  before do
    sign_in(subject)
    subject.skip_confirmation!
    subject.save
    login_as(subject)
  end

  let(:post_one) do
    Post.new(author: subject, title: 'Hello rails', text: 'Rails is great', comments_counter: 0, likes_counter: 0)
  end

  before { subject.save }
  before { post_one.save }
  before { get user_posts_path(subject.id) }

  describe 'GET /index' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include(post_one.title)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get user_post_path(subject.id, post_one.id)
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the correct template' do
      get user_post_path(subject.id, post_one.id)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get user_post_path(subject.id, post_one.id)
      expect(response.body).to include(post_one.title)
    end
  end
end
