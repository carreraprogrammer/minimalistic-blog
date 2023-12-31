require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include Devise::Test::IntegrationHelpers
  subject do
    User.create!(name: 'Daniel', photo: 'photo.png', bio: 'Lorem ipsum', post_counter: 3, email: 'daniel@gmail.com',
                 password: 'password')
  end
  before do
    sign_in(subject)
    subject.skip_confirmation!
    subject.save
    login_as(subject)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the correct template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include(subject.name)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get user_path(subject.id)
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the correct template' do
      get user_path(subject.id)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get user_path(subject.id)
      expect(response.body).to include(subject.name)
    end
  end
end
