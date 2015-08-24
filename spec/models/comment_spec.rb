require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe "Comment Creation" do
    before do
      User.create!(username: "testing", password: "123456")
      User.first.goals.create!(title: "Fizzle")
    end

    it "validates body presence" do
      comment = User.first.goals.first.comments.new(author_id: User.first.id)
      comment.save
      expect(comment.errors.full_messages).to include("Body can't be blank")
    end
  end
end
