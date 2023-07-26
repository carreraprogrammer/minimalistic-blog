require 'rails_helper'
require 'securerandom'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Anything', photo: 'Lorem ipsum', bio: "It doesn't matter", post_counter: 0) }
  let(:user_two) { User.create(name: 'Anything two', photo: 'Lorem ipsum', bio: "It doesn't matter", post_counter: 0) }

  subject do
    described_class.new(author: user,
                        title: 'Anything',
                        text: 'Lorem ipsum',
                        comments_counter: 0,
                        likes_counter: 0)
  end

  let(:comment_one) { Comment.create(post: subject, author: user, text: 'Hello Anything') }
  let(:comment_two) { Comment.create(post: subject, author: user_two, text: 'Hello Anything two') }
  let(:comment_three) { Comment.create(post: subject, author: user, text: 'How is going?') }
  let(:comment_fourth) { Comment.create(post: subject, author: user_two, text: 'Fine, thanks') }
  let(:comment_fifth) { Comment.create(post: subject, author: user_two, text: 'And you?') }
  let(:comment_sixth) { Comment.create(post: subject, author: user, text: 'Fine too') }

  it { should belong_to(:author) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a title with most of 250 char' do
    subject.title = SecureRandom.hex(325)
    expect(subject).to_not be_valid
  end

  it 'is not valid with a comments_counter less than 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid with a comments_counter that is not an integer' do
    subject.comments_counter = 1.5
    expect(subject).to_not be_valid
  end

  it 'is not valid with a likes_counter less than 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid with a likes_counter that is not an integer' do
    subject.likes_counter = 1.5
    expect(subject).to_not be_valid
  end

  describe '#recent_comments' do
    it 'returns only 5 comments' do
      comment_one
      comment_two
      comment_three
      comment_fourth
      comment_fifth
      comment_sixth
      expect(subject.recent_comments.size).to eq(5)
    end

    it 'returns the first five comments' do
      comment_one
      comment_two
      comment_three
      comment_fourth
      comment_fifth
      comment_sixth
      expect(subject.recent_comments).to eq([comment_one, comment_two, comment_three, comment_fourth, comment_fifth])
    end
  end

  describe '#update_post_counter' do
    it 'should increment author post counter' do
      expect { subject.save }.to change { user.post_counter }.by(1)
    end
  end

  describe '#decrease_post_counter' do
    it 'should decrement author post counter' do
      subject.save
      expect { subject.destroy }.to change { user.post_counter }.by(-1)
    end
  end
end
