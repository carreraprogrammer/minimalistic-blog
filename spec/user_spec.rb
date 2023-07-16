require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    described_class.new(name: "Anything",
                        photo: "Lorem ipsum",
                        bio: "It doesn't matter",
                        post_counter: 0)
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a post_counter less than 0" do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it "is not valid with a post_counter that is not an integer" do
    subject.post_counter = 1.5
    expect(subject).to_not be_valid
  end
end
