require 'rails_helper'
include SessionsHelper

RSpec.describe CommentsController, type: :controller do
  let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:other_user) { User.create!(name: RandomData.random_name, email: RandomData.random_email, password: "helloworld", role: :member) }
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
  let(:my_comment) { Comment.create!(body: 'Comment Body', post: my_post, user: my_user) }
end
