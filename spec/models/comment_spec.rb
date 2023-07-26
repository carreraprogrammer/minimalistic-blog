require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'Daniel', photo: 'photo.png', bio: 'Lorem ipsum') }
  let(:post) { Post.new(author: user, title: 'Hello rails', text: 'Rails is great') }

  subject { Comment.new(post: post, author: user, text: 'Hello!') }

  before { subject.save }

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
