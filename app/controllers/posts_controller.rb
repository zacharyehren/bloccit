class PostsController < ApplicationController
  def index
  #declare an instance variable @posts and assign it to a collection of Post objects (from the Post model) using the all method provided by ActiveRecord
    @posts = Post.all
  end

  def show
    #we find the post that corresponds to the id in the params we passed to show and assign it to @post
    #unlike the index method, in the show method we populate an instance variable with a single post rather than a collection of posts
    @post = Post.find(params[:id])
  end

  def new
    #create an instance variable, @post, then assign it to an empty post returned by Post.new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    #if we successfully save Post to the database, we display a success message
    if @post.save
    #The flash hash provides a way to pass temporary values between actions. Any value placed in flash will be available in the next action and then deleted
      flash[:notice] = "Post was saved."
      #redirecting to post will direc the user to the posts show view
      redirect_to @post
    else
      #if we do not successfully save Post to the database, we display an error message and render the new view again.
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was updated"
      redirect_to @post
    else
      flash.now[:alert] = "There was an error saving the post. Please try again"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] =  "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

end
