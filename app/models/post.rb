class Post < ActiveRecord::Base
  #comments are dependent on a post's existence because of the has_many :comments declaration in Post
  #when we delete a post, we also need to delete all related comments. We'll perform a cascade delete, which ensures
  #that when a post is deleted, all of its comments are too
  belongs_to :topic
  has_many :comments, dependent: :destroy
end
