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
#we associate post with topic via topic.posts.create!. This is a chained method call which creates a post for a given topic
  let(:post) { topic.posts.create!(title: title, body: body) }
  it {is_expected.to belong_to(:topic) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  #We test whether post has attributes named title and body. This tests whether post
  #will return a non-nil value when post.title and post.body is called
  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: title, body: body)
    end
  end
end
