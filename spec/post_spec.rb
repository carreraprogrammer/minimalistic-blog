require 'rails_helper'
require 'securerandom'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Anything', photo: 'Lorem ipsum', bio: "It doesn't matter", post_counter: 0) }

  subject do
    described_class.new(author: user,
                        title: 'Anything',
                        text: 'Lorem ipsum',
                        comments_counter: 0,
                        likes_counter: 0)
  end

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
end
