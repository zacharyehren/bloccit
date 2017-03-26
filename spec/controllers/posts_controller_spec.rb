require 'rails_helper'
require 'random_data'
#RSpec created a test for PostsController. type: controller tells RSpec to treat the test as a controller test
RSpec.describe PostsController, type: :controller do
#creates a post and assigns it to my_post using let
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }



#When new is invoked, a new and unsaved Post object is created.
  describe "GET new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
  end
#we expect PostsController#new to render the posts new view
    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      #we use the render_template method to verify the correct template (view) is rendered
      expect(response).to render_template :new
    end
#we expect the @post instance variable to be initialized by PostsController#new
    it "instantiates @post" do
      get :new, topic_id: my_topic.id
      #assigns gives us access to the @post variable assigning it to post
      expect(assigns(:post)).to_not be_nil
    end
  end
#when create is invoked the newly created object is persisted in the db
#we expect that after PostsController#create is called, the count of Post instance (ie the rows in the posts table) in the DB will +1
  describe "POST create" do
    it "increases the number of Post by 1" do
      expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end
#when create is posted to, we expect the newly created post to be assigned to @post
    it "assigns the new post to @post" do
      post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        #because the route for the posts show view will also be updated to reflect nested posts, instead of redirecting to Post.last,
        #we redirect to [my_topic, Post.last]. Rails' router can take an array of objects and build a route to the show page of the last object in the array
        #nesting it under the other objects in the array.
        expect(response).to redirect_to [my_topic, Post.last]
      end
  end

  describe "GET show" do
    it "returns http success" do
    #posts routes will now include the topic_id of the parent topic so we update our get :show request to include the id the parent topic
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      #we expect the response to return the show view using the render_template matcher
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to render_template :show
    end
    it "assigns my_post to @post" do
      get :show, topic_id: my_topic.id, id: my_post.id
      #we expect the post to equal my_post because we call show with the id of my_post
      expect(assigns(:post)).to eq(my_post)
    end

  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_post.id
      expect(response).to render_template :edit
    end
    it "assigns post to be updated to @post" do
      get :edit, topic_id: my_topic.id, id: my_post.id
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

      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
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
      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to [my_topic, my_post]
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      #we search the DB for a post with an id equal to my_post.id. this returns an Array.
      #we assign the size of the array to count and we expect count to equal zero. this asserts that the DB wont have a matching post after destroy is called
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to topic show" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      #expect to be redirected to the posts index view after a post has been deleted
      expect(response).to redirect_to my_topic
    end
  end

end
