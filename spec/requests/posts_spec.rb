require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  
  subject { User.new(name: 'Daniel', photo: 'photo.png', bio: 'Lorem ipsum', post_counter: 3) }

  let(:post_one) {Post.new(author: subject, title: 'Hello rails', text: 'Rails is great', comments_counter: 0, likes_counter: 0)}

  before { subject.save }
  before { post_one.save }
  before { get user_posts_path(subject.id)}

  describe 'GET /index' do
    it "returns http success" do
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it "renders the correct template" do
      expect(response).to render_template(:index)
    end

    it "includes the correct placeholder text in the response body" do
      expect(response.body).to include(post_one.title)
    end
  end
end
