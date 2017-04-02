class Post < ActiveRecord::Base
  #comments are dependent on a post's existence because of the has_many :comments declaration in Post
  #when we delete a post, we also need to delete all related comments. We'll perform a cascade delete, which ensures
  #that when a post is deleted, all of its comments are too
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
