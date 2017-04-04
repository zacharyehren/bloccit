class PostsController < ApplicationController
#we use a before_action filter to call the require_sign_in method before each of our controller action, except for show
before_action :require_sign_in, except: :show
#we use a second before_action filter to check the role of a signed-in user. if the current_user isn't authorized based on their role, we'll redirect them to the posts show view
before_action :authorize_user, except: [:show, :new, :create]

  def show
    #we find the post that corresponds to the id in the params we passed to show and assign it to @post
    #unlike the index method, in the show method we populate an instance variable with a single post rather than a collection of posts
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    #create an instance variable, @post, then assign it to an empty post returned by Post.new
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
#we assign topic to a post
    @post.user = current_user

    #if we successfully save Post to the database, we display a success message
    if @post.save
    #The flash hash provides a way to pass temporary values between actions. Any value placed in flash will be available in the next action and then deleted
      flash[:notice] = "Post was saved."
      #redirecting to post will direc the user to the posts show view using the nested post path
      redirect_to [@topic, @post]
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
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated"
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] =  "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private
#this method whitelists the title and body attributes in post to be able to use Mass Assignment
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that"
      redirect_to [post.topic, post]
    end
  end
end
