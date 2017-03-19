require 'rails_helper'

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

  describe "offensive post" do
    it "deletes every 5th post" do
      
    end
  end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
