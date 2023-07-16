require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'David', photo: 'photo.png', bio: 'A full-stack developer') }
  let(:post) { Post.create(author: user, title: 'Hello rails', text: 'Rails is great') }

  subject { Like.new(post: post, author: user) }

  before { subject.save }

  it { should belong_to(:post) }
  it { should belong_to(:author) }

  it 'updates the likes counter for a post' do
    expect(post.likes_counter).to eq(1)
  end

  it 'decrease the likes counter for a post' do
    subject.decrease_likes_counter
    expect(post.likes_counter).to eq(0)
  end
end
