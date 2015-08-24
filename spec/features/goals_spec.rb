require 'spec_helper'
require 'rails_helper'

feature "when not logged in" do
  before do
    sign_up_as_testing_username
    User.first.goals.create!(title: "fail an exam", privacy: "Private")
    User.first.goals.create!(title: "sleep through lecture")
    sign_out
    visit user_url(User.first)
  end

  it "does display public goals" do
    expect(page).to have_content("sleep through lecture")
  end

  it "doesn't display private goals" do
    expect(page).not_to have_content("fail an exam")
  end
end

feature "when logged in" do
  before do
    sign_up_as_testing_username
    User.first.goals.create!(title: "fail an exam", privacy: "Private")
    User.first.goals.create!(title: "sleep through lecture")
    visit user_url(User.first)
  end

  context "own show page" do
    it "does display own public goals" do
      expect(page).to have_content("sleep through lecture")
    end

    it "does display own private goals" do
      expect(page).to have_content("fail an exam")
    end

    it "should allow editing of own goals" do
      expect(page).to have_link("Edit Goal")
    end

    it "should allow deletion of own goals" do
      expect(page).to have_button("Delete Goal")
    end

    it "should track own goal completion" do
      expect(page).to have_content("Completed")
    end
  end



  context "others' show page" do
    before do
      sign_out
      sign_up("test2")
      visit user_url(User.first)
    end

    it "does display others' public goals" do
      expect(page).to have_content("sleep through lecture")
    end

    it "doesn't display others' private goals" do
      expect(page).not_to have_content("fail an exam")
    end

    it "doesn't allow editing of other's goals" do
      expect(page).not_to have_link("Edit Goal")
    end

    it "doesn't allow deletion of others' goals" do
      expect(page).not_to have_button("Delete Goal")
    end

    it "should track others' goal completion" do
      expect(page).to have_content("Completed")
    end
  end
end
