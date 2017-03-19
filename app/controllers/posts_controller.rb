class PostsController < ApplicationController
  def index
  #declare an instance variable @posts and assign it to a collection of Post objects using the all method provided by ActiveRecord
    @posts = Post.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
