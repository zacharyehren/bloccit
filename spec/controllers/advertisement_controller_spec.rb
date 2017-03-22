require 'rails_helper'
require 'random_data'

RSpec.describe AdvertisementController, type: :controller do
  let(:ad) do
    Advertisement.create(
    id: 1,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: 99
    )
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [ad] to @advertisement" do
      get :index
      expect(assigns(:ads)).to eq([ad])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: ad.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, {id: ad.id}
      expect(response).to render_template :show
    end
    it "assigns ad to @advertisement" do
      get :show, {id: ad.id}
      expect(assigns(:ad)).to eq(ad)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    it "instantiates @advertisement" do
      get :new
      expect(assigns(:ad)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of Post by 1" do
      expect{post :create, ad: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Advertisement,:count).by(1)
    end
#when create is posted to, we expect the newly created post to be assigned to @post
    it "assigns the new post to @post" do
      post :create, ad: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:ad)).to eq Advertisement.last
    end

    it "redirects to the new post" do
        post :create, ad: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to Advertisement.last
      end
  end
  #
  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
