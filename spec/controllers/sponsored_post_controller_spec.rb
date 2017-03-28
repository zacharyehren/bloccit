require 'rails_helper'
require 'random_data'

RSpec.describe SponsoredPostController, type: :controller do
let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
let(:my_sponsored) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1) }

  describe "GET #show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_sponsored.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_sponsored.id
      expect(response).to render_template :show
    end
    it "assigns my_sponsored to @sponsoredpost" do
      get :show, topic_id: my_topic.id, id: my_sponsored.id
      expect(assigns(:sponsored_post)).to eq(my_sponsored)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end
    it "instantiates @sponsored_post" do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsored_post)).to_not be_nil
    end
  end

  # describe "POST create" do
  #   it "increases the number of SponsoredPost by 1" do
  #     expect{post :create, topic_id: my_topic.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1}}.to change(SponsoredPost,:count).by(1)
  #   end
  #   it "assigns the new sponsored post to @sponsored_post" do
  #     post :create, topic_id: my_topic.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1}}.to change(SponsoredPost,:count).by(1)
  #     expect(assigns(:sponsored_post)).to eq SponsoredPost.last
  #   end
  #   it "redirects to the new sponsored post" do
  #     post :create, topic_id: my_topic.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1}}.to change(SponsoredPost,:count).by(1)
  #     expect(response).to redirect_to [my_topic, SponsoredPost.last]
  #   end
  # end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_sponsored.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_sponsored.id
      expect(response).to render_template :edit
    end
    it "assigns post to be updated to @post" do
      get :edit, topic_id: my_topic.id, id: my_sponsored.id
      my_sponsored_instance = assigns(:sponsored_post)
      expect(my_sponsored_instance.id).to eq my_sponsored.id
      expect(my_sponsored_instance.title).to eq my_sponsored.title
      expect(my_sponsored_instance.body).to eq my_sponsored.body
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = 2
      put :update, topic_id: my_topic.id, id: my_sponsored.id, sponsored_post: {title: new_title, body: new_body, price: new_price}
      updated_post = assigns(:sponsored_post)
      expect(updated_post.id).to eq my_sponsored.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
      expect(updated_post.price).to eq new_price
    end
    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, topic_id: my_sponsored.id, id: my_sponsored.id, sponsoredpost: {title: new_title, body: new_body}
      expect(response).to redirect_to [my_topic, my_sponsored]
    end
  end

  describe "DELETE destroy" do
    it "deletes the sponsored post" do
      delete :destroy, topic_id: my_topic.id, id: my_sponsored.id
      count = SponsoredPost.where({id: my_sponsored.id}).size
      expect(count).to eq 0
    end
    it "redirects to the topic show" do
      delete :destroy, topic_id: my_topic.id, id: my_sponsored.id
      expect(repsonse).to redirect_to my_sponsored
    end
  end
end
