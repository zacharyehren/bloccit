require 'rails_helper'
require 'random_data'

RSpec.describe Vote, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:vote) { create(:vote, post: post, user: user) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
#we test that value is present when votes are created
  it { is_expected.to validate_presence_of(:value) }
#we validate that vlaue is either -1 (a down vote) or 1 (an up vote)
  it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }

  describe "update_post callback" do
    it "triggers update_post on save" do
      #we expect update_post_rank to be called on vote after it's saved
      expect(vote).to receive(:update_post).at_least(:once)
      vote.save!
    end

    it "#update_post should call update_rank on post" do
      #we expect that the vote's post will receive a call to update_rank
      expect(post).to receive(:update_rank).at_least(:once)
      vote.save!
    end
  end
end
