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
end
