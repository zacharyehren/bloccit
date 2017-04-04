require 'random_data'

#Create users
5.times do
  User.create!(
  name:     RandomData.random_name,
  email:    RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all

  #Create topics
  15.times do
    Topic.create!(
      name: RandomData.random_sentence,
      description: RandomData.random_paragraph
    )
  end
  topics = Topic.all

  #Create Posts
  50.times do
#we use create! with a bang(!). Adding a ! instructs the method to raise
#an error if there's a probelem with the data we're seeding. Using create without a bang
#could fail without warning, causing the error to surface later
  Post.create!(
  #we use methods from a class that doesn't exist yet (RandomData) that will create
  #random strings for title and body. Writing code for classes and methods that don't exist
  #yet is known as "wishful coding" and can increase productivity because it allows you to stay focused on one problem at a time
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

posts = Post.all

#Create Comments
#we call times on an Integer. This will run a given block the specified # of times
100.times do
  Comment.create!(
  #we call sample on the array returned by Post.all in order to pick a random post to associate each comment with
  #sample returns a random element from the array every time it's called
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

#Create an admin user
admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

#Create a member
member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
