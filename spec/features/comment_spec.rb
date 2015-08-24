require 'spec_helper'
require 'rails_helper'

feature "User Show Page" do
  before do
    sign_up_as_testing_username
  end

  it "allows a comment to be added" do
    expect(page).to have_button("Add Comment")
  end

  it "allows a comment to be deleted by author" do
    fill_in "Body", with: "Comment"
    click_button("Add Comment")
    expect(page).to have_button("Delete Comment")
  end
end

feature "Goal Show Page" do
  before do
    sign_up_as_testing_username
    User.first.goals.create(title: "belly flop")
    visit goal_url(Goal.first)
  end

  it "allows a comment to be added" do
    expect(page).to have_button("Add Comment")
  end

  it "allows a comment to be deleted by author" do
    fill_in "Body", with: "Comment"
    click_button("Add Comment")
    expect(page).to have_button("Delete Comment")
  end
end
