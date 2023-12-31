require 'rails_helper'

RSpec.describe Comment, type: :model do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.new(name: 'Daniel', photo: 'photo.png', bio: 'Lorem ipsum', email: 'Daniel@gmail.com', password: 'password123')
  end
  let(:post) { Post.new(author: user, title: 'Hello rails', text: 'Rails is great', comments_counter: 0) }

  subject { Comment.new(post:, author: user, text: 'Hello!') }

  before do
    user.skip_confirmation!
    user.save
    post.save
    subject.save
  end

  it { should belong_to(:post) }
  it { should belong_to(:author) }

  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_most(100) }
  end

  it 'belongs to an author' do
    expect(subject.author).to eql user
  end

  it 'belongs to a post' do
    expect(subject.post).to eql post
  end

  it 'increments the comments_counter of the post' do
    expect(post.comments_counter).to eq(1)
  end

  it 'decrements the comments_counter of the post' do
    subject.decrease_comments_counter
    expect(post.comments_counter).to eq(0)
  end
end
