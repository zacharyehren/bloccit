require 'rails_helper'
require 'random_data'
#RSpec created a test for PostsController. type: controller tells RSpec to treat the test as a controller test
RSpec.describe PostsController, type: :controller do
#creates a post and assigns it to my_post using let
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      #the test performs a GET on the index view and expects the response to be successful
      get :index
      expect(response).to have_http_status(:success)
    end


    it "assigns [my_post] to @posts" do
       get :index
  #because the test created one post (my_post), we expect index to return an array of one item
  #We use assigns, a method in ActionController::TestCase. Assigns gives the test access to instance
  #variables assigned in the action that are available for the view.
  expect(assigns(:posts)).to eq([my_post])
   end
  end

#When new is invoked, a new and unsaved Post object is created.
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
  end
#we expect PostsController#new to render the posts new view
    it "renders the #new view" do
      get :new
      #we use the render_template method to verify the correct template (view) is rendered
      expect(response).to render_template :new
    end
#we expect the @post instance variable to be initialized by PostsController#new
    it "instantiates @post" do
      get :new
      #assigns gives us access to the @post variable assigning it to post
      expect(assigns(:post)).to_not be_nil
    end
  end
#when create is invoked the newly created object is persisted in the db
#we expect that after PostsController#create is called, the count of Post instance (ie the rows in the posts table) in the DB will +1
  describe "POST create" do
    it "increases the number of Post by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end
#when create is posted to, we expect the newly created post to be assigned to @post
    it "assigns the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
        post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to Post.last
      end
  end

  describe "GET show" do
    it "returns http success" do
      #we pass my_post.id to show as a parameter. These parameters are passed to the params hash
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      #we expect the response to return the show view using the render_template matcher
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end
    it "assigns my_post to @post" do
      get :show, {id: my_post.id}
      #we expect the post to equal my_post because we call show with the id of my_post
      expect(assigns(:post)).to eq(my_post)
    end

  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, {id: my_post.id}
      expect(response).to render_template :edit
    end
    it "assigns post to be updated to @post" do
      get :edit, {id: my_post.id}
      post_instance = assigns(:post)
      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      #we test that @post was updated with the title and body was passed to update
      #we also test taht @post's id was not changed
      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      #expect to be redirected to the posts show view after the update
      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to my_post
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, {id: my_post.id}
      #we search the DB for a post with an id equal to my_post.id. this returns an Array.
      #we assign the size of the array to count and we expect count to equal zero. this asserts that the DB wont have a matching post after destroy is called
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to posts index" do
      delete :destroy, {id: my_post.id}
      #expect to be redirected to the posts index view after a post has been deleted 
      expect(response).to redirect_to posts_path
    end
  end

end
