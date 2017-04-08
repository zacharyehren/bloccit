require 'rails_helper'
require 'random_data'


RSpec.describe Post, type: :model do
  #Using the let method, we create a new instance of the Post class and name it post
  #let dynamically defines a method(in this case, post) and upon first call within
  #a spec (the it block), computes and stores the returned value
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
#create a parent topic for post
  let(:topic) { Topic.create!(name: name, description: description) }
#we create a user to associate with a test post
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
#we associate user with post when we create the test post
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }

  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  #We test whether post has attributes named title and body. This tests whether post
  #will return a non-nil value when post.title and post.body is called
  describe "attributes" do
    it "has title, body, and user attributes" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end

  describe "voting" do
     before do
       3.times { post.votes.create!(value: 1) }
       2.times { post.votes.create!(value: -1) }
       @up_votes = post.votes.where(value: 1).count
       @down_votes = post.votes.where(value: -1).count
     end

     describe "#up_votes" do
       it "counts the number of votes with value = 1" do
         expect( post.up_votes ).to eq(@up_votes)
       end
     end

     describe "#down_votes" do
       it "counts the number of votes with value = -1" do
         expect( post.down_votes ).to eq(@down_votes)
       end
     end

     describe "#points" do
       it "returns the sum of all down and up votes" do
         expect( post.points ).to eq(@up_votes - @down_votes)
       end
     end

     describe "#update_rank" do
       it "calculates the correct rank" do
         post.update_rank
         expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
       end

       it "updates the rank when an up vote is created" do
         old_rank = post.rank
         post.votes.create!(value: 1)
         expect(post.rank).to eq (old_rank + 1)
       end

       it "updates the rank when a down vote is created" do
         old_rank = post.rank
         post.votes.create!(value: -1)
         expect(post.rank).to eq (old_rank - 1)
       end
     end 
   end
end
