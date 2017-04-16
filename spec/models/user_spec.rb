require 'rails_helper'
require 'random_data'

RSpec.describe User, type: :model do
#:user is created by the the factory
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:favorite) { Favorite.create!(post: post, user: user) }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }

  # Shoulda tests for name
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  # Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }

  # Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: user.name, email: user.email)
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end
    #we expect users will respond to admin?, which will return whether or not a user is an admin
    #this will be implemented using the ActiveRecord::Enum class
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
    #we expect users will respond to member?, which will return whether or not a user is a member
    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "roles" do
    it "is member by default" do
      expect(user.role).to eql("member")
    end

    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #member" do
        expect(user.member?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end


  #we wrote a test that does not follow the same conventions as our previous tests
  #we are testing for a value that we know should be invalid
  describe "invalid user" do
     let(:user_with_invalid_name) { build(:user, name: "") }
     let(:user_with_invalid_email) { build(:user, email: "")}

     it "should be an invalid user due to blank name" do
       expect(user_with_invalid_name).to_not be_valid
     end

     it "should be an invalid user due to blank email" do
       expect(user_with_invalid_email).to_not be_valid
     end
   end

   describe "#favorite_for(post)" do
     before do
       topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
       @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
     end

     it "returns 'nil' if the user has not favorited the post" do
       expect(user.favorite_for(@post)).to be_nil
     end

     it "returns the appropriate favorite if it exists" do
       favorite = user.favorites.where(post: @post).create
       expect(user.favorite_for(@post)).to eq(favorite)
     end
   end

   describe ".avatar_url" do
     #we build a user with FactoryGirl. We pass it the blochead email to build, which overrides the email address that would be generated.
     #we are overriding the default email address with a known one so that we can test against a specific string that we know Gravatar will return.
     let(:known_user) { create(:user, email: "blochead@bloc.io") }
     it "returns the proper Gravatar url for a known email entity" do
    #we set the expected string that Gravatar should return for blochead@bloc.io. The s=48 query parameter specifies that we want the returned image to be 48x48px
       expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
    #we expect known_user.avatar_url to return the URL listed above
       expect(known_user.avatar_url(48)).to eq(expected_gravatar)
     end
   end

   describe "favorited_posts" do
     before do
       topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
       @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
       @comments = @post.comments.create!(body: RandomData.random_paragraph)
     end

     describe "favorited_posts return" do
       it "returns all the user's favorite posts" do
       expect(user.favorited_posts).to eq(favorite)
     end
    end

     describe "favorited post comments" do
       it "lists the post's correct number of comments" do
         expect(post.comments.count).to eq(@comments)
       end
     end
  end
end
