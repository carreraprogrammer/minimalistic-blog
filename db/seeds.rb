# db/seeds.rb

# Create users
user1 = User.new(
  name: 'Clerick',
  email: 'user1@example.com',
  password: 'password123',
  bio: 'Travel enthusiast, photographer, and nature lover. Exploring the world one step at a time.',
  photo: 'https://i.pinimg.com/564x/e7/a7/58/e7a7584292d4ad92db80fb7f7df5a852.jpg'
)
user1.skip_confirmation!
user1.save!

user2 = User.new(
  name: 'Sarah',
  email: 'user2@example.com',
  password: 'password456',
  bio: 'Aspiring chef with a passion for cats and experimenting in the kitchen. Food is love!',
  photo: 'https://i.pinimg.com/564x/5c/9e/d1/5c9ed10a6dff7e9e8790666fe137edfc.jpg'
)
user2.skip_confirmation!
user2.save!

# Create additional users
user3 = User.new(
  name: 'Mark',
  email: 'user3@example.com',
  password: 'password789',
  bio: 'Tech geek, gamer, and anime fan. Building new worlds in virtual reality.',
  photo: 'https://i.pinimg.com/originals/f0/c4/fb/f0c4fbdb53e45e7423a4127eb54b7ef8.png'
)
user3.skip_confirmation!
user3.save!

user4 = User.new(
  name: 'Dannia',
  email: 'user4@example.com',
  password: 'passwordabc',
  bio: 'Fitness enthusiast and personal trainer. Helping people achieve their fitness goals.',
  photo: 'https://i.pinimg.com/564x/89/62/fb/8962fb71717ccb0864986b6068f1bb57.jpg'
)
user4.skip_confirmation!
user4.save!

user5 = User.new(
  name: 'Cielo',
  email: 'user5@example.com',
  password: 'passwordxyz',
  bio: 'Art lover and aspiring artist. Expressing emotions through colorful creations.',
  photo: 'https://i.pinimg.com/564x/fc/cb/77/fccb770e83283719e00a2ceff78191e3.jpg'
)
user5.skip_confirmation!
user5.save!

# Create posts
post1 = Post.create!(
  title: 'Amazing Sunset',
  text: 'Captured this breathtaking sunset during my travels. Nature never ceases to amaze me! 🌅',
  author: user1
)

post2 = Post.create!(
  title: 'Delicious Food Adventure',
  text: 'Tried out a new recipe today, and it turned out to be a masterpiece! Cooking brings me so much joy. 😋🍳',
  author: user2
)

post3 = Post.create!(
  title: 'Gaming Marathon',
  text: 'Just completed an epic 10-hour gaming marathon with friends. We conquered new lands and defeated mighty dragons! 🎮🐉',
  author: user3
)

post4 = Post.create!(
  title: 'Morning Workout',
  text: 'Kicked off the day with an intense workout session. Feeling pumped and ready to conquer the day! 💪🏋️‍♀️',
  author: user4
)

post5 = Post.create!(
  title: 'Colorful Artwork',
  text: 'Finished my latest artwork today. Embracing colors and emotions on the canvas is pure bliss! 🎨😊',
  author: user5
)

# Create comments
# Create comments
comment1 = Comment.create!(
  text: 'Great post, Clerick! The colors in the sky are stunning.',
  author: user3,
  post: post1
)

comment2 = Comment.create!(
  text: 'I love trying out new recipes too, Sarah! Your food looks delicious!',
  author: user1,
  post: post2
)

comment3 = Comment.create!(
  text: 'Mark, that game sounds epic! Count me in next time!',
  author: user4,
  post: post3
)

comment4 = Comment.create!(
  text: 'Dannia, you inspire me to stay fit and active!',
  author: user2,
  post: post4
)

comment5 = Comment.create!(
  text: 'Cielo, your artwork is amazing! Keep shining with those colors!',
  author: user1,
  post: post5
)

comment6 = Comment.create!(
  text: 'Thanks, Clerick! Your travel photos are always a treat.',
  author: user2,
  post: post1
)

comment7 = Comment.create!(
  text: 'I need that recipe, Sarah! Looks like a masterpiece indeed!',
  author: user3,
  post: post2
)

comment8 = Comment.create!(
  text: 'Mark, we should form a gaming squad! I\'m up for the challenge.',
  author: user5,
  post: post3
)

comment9 = Comment.create!(
  text: 'Keep rocking those workouts, Dannia! You\'re an inspiration.',
  author: user3,
  post: post4
)

comment10 = Comment.create!(
  text: 'Cielo, your art always brightens my day. Keep creating!',
  author: user4,
  post: post5
)
