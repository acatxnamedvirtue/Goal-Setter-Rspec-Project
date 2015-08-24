require 'spec_helper'
require 'rails_helper'

feature "leaderboard" do
  before do
    sign_up_as_testing_username
    User.first.goals.create!(title: "fail an exam", privacy: "Private")
    User.first.goals.create!(title: "sleep through lecture")
    visit root_url
  end

  it "does display public goals" do
    expect(page).to have_content("sleep through lecture")
  end

  it "doesn't display private goals" do
    expect(page).not_to have_content("fail an exam")
  end
end
