require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:vote) { Vote.create!(value: 1, post: post, user: user) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
#we test that value is present when votes are created
  it { is_expected.to validate_presence_of(:value) }
#we validate that vlaue is either -1 (a down vote) or 1 (an up vote)
  it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }
end
