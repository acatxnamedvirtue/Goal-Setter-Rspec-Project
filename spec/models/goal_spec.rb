require 'rails_helper'

RSpec.describe Goal, :type => :model do
  describe "Goal Creation" do
    before do
      User.create!(username: "testing", password: "123456")
    end

    it "validates title presence" do
      goal = User.first.goals.new
      goal.save
      expect(goal.errors.full_messages).to include("Title can't be blank")
    end

    it "validates user_id presence" do
      goal = Goal.new(title: "10 pounds")
      goal.save
      expect(goal.errors.full_messages).to include("User can't be blank")
    end

    it "validates privacy either Public or Private" do
      goal = User.first.goals.new(title: "10 pounds", privacy: "sennacy")
      goal.save
      expect(goal.errors.full_messages).to include("Privacy must be either Public or Private")
    end
  end
end
