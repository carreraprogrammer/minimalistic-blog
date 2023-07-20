require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do

    subject {User.new(name: 'Daniel', photo: 'photo.png', bio: 'Lorem ipsum', post_counter: 3)}

    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "renders the correct template" do
      get users_path
      expect(response).to render_template(:index)
    end

    it "includes the correct placeholder text in the response body" do
      subject.save
      get users_path
      expect(response.body).to include(subject.name)
    end
  end
end
