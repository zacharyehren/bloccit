class Post < ActiveRecord::Base
  #comments are dependent on a post's existence because of the has_many :comments declaration in Post
  #when we delete a post, we also need to delete all related comments. We'll perform a cascade delete, which ensures
  #that when a post is deleted, all of its comments are too
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  after_create :create_vote

#this relates the model and allows us to call post.votes. We all add dependent: :destroy to ensure that votes are destroyed when their parent post is deleted
  has_many :votes, dependent: :destroy

  default_scope { order('rank DESC') }
#we use a lambda (->) to ensure the user is present or signed in. If the user is present, we return all posts. If not, we use the Active Record joins method to retrieve all posts which are public
  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

#we find the up votes for a post by passing value: 1 to where. This fetches a collection of votes with a value of 1.
#This fetches a collection of votes with a value of 1. We then call count on the collection to get a total of all up votes.
  def up_votes
    votes.where(value: 1).count
  end
#same as up_votes but collects all values of -1
  def down_votes
    votes.where(value: -1).count
  end
#we use ActiveRecord's sum method to add the value of all the given post's votes.
#passing :value to sum tells it what attribute to sum in the collection
  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  private

  def create_vote
    user.votes.create(value: 1, post: self)
  end
end
