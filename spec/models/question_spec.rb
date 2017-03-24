require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "attributes" do
    let(:question) { Question.new(title: "New Question Title", body: "New Question Body", resolved: false) }

    it "should repond to title" do
      expect(question).to respond_to(:title)
    end

    it "should respond to body" do
      expect(question).to respond_to(:body)
    end

    it "shoudl respond to resolved" do
      expect(question).to respond_to(:resolved)
    end
  end
end
