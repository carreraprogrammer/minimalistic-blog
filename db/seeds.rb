# Create users
# db/seeds.rb

# Create users
user1 = User.new(
  name: 'User 1',
  email: 'user1@example.com',
  password: 'password123',
  bio: 'Hello, I am User 1 and this is my bio.',
  photo: 'https://t4.ftcdn.net/jpg/02/14/74/61/360_F_214746128_31JkeaP6rU0NzzzdFC4khGkmqc8noe6h.jpg'
)

user1.skip_confirmation! 
user1.save!

user2 = User.new(
  name: 'User 2',
  email: 'user2@example.com',
  password: 'password456',
  bio: 'Hello, I am User 2 and this is my bio.',
  photo: 'https://img.freepik.com/free-photo/cheerful-dark-skinned-woman-smiling-broadly-rejoicing-her-victory-competition-among-young-' + 
    'writers-standing-isolated-against-grey-wall-people-success-youth-happiness-concept_273609-1246.jpg'
)

user2.skip_confirmation! 
user2.save!

# Resto de tu código de seeds...

  
  # Create posts
  user1 = User.find_by(email: 'user1@example.com')
  user2 = User.find_by(email: 'user2@example.com')
  
  Post.create!(
    title: 'Post 1',
    text: 'This is the first post created by User 1.',
    author: user1
  )
  
  Post.create!(
    title: 'Post 2',
    text: 'This is the first post created by User 2.',
    author: user2
  )
  
  # Create comments
  post1 = Post.find_by(title: 'Post 1')
  post2 = Post.find_by(title: 'Post 2')
  
  Comment.create!(
    text: 'Great post!',
    author: user2,
    post: post1
  )
  
  Comment.create!(
    text: 'Thanks for sharing.',
    author: user1,
    post: post2
  )
  