require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: 'Anything',
                        photo: 'Lorem ipsum',
                        bio: "It doesn't matter",
                        post_counter: 0)
  end

  let(:post_one) do
    Post.create(author: subject, title: 'Anything', text: 'Lorem ipsum', comments_counter: 0, likes_counter: 0)
  end
  let(:post_two) do
    Post.create(author: subject, title: 'Anything', text: 'Lorem ipsum', comments_counter: 0, likes_counter: 0)
  end
  let(:post_three) do
    Post.create(author: subject, title: 'Anything', text: 'Lorem ipsum', comments_counter: 0, likes_counter: 0)
  end
  let(:post_fourth) do
    Post.create(author: subject, title: 'Anything', text: 'Lorem ipsum', comments_counter: 0, likes_counter: 0)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a post_counter less than 0' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid with a post_counter that is not an integer' do
    subject.post_counter = 1.5
    expect(subject).to_not be_valid
  end

  describe '#recent_posts' do
    it 'returns only 3 posts' do
      post_one
      post_two
      post_three
      post_fourth
      expect(subject.recent_posts.size).to eq(3)
    end

    it 'returns the most recent posts' do
      post_one
      post_two
      post_three
      post_fourth
      expect(subject.recent_posts).to eq([post_fourth, post_three, post_two])
    end
  end
end
