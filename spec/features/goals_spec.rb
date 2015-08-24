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
      first(:link, "sleep through lecture").click
      expect(page).to have_content("Completed")
    end

    it "should have an add goal link on User show page" do
      expect(page).to have_link("Add Goal")
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
      first(:link, "sleep through lecture").click
      expect(page).to have_content("Completed")
    end
  end
end

feature "Goal Creation/Editing" do
  before do
    sign_up_as_testing_username
  end
  before(:each) { click_link("Add Goal") }


  it "should have a field for title" do
    expect(page).to have_content("Title")
  end

  it "should have a field for description" do
    expect(page).to have_content("Description")
  end

  it "should have a radio button for privacy" do
    expect(page).to have_content("Private")
    expect(page).to have_content("Public")
  end

  it "should have a radio button for completion" do
    expect(page).to have_content("Yes")
    expect(page).to have_content("No")
  end

  it "should allow a goal to be added" do
    fill_in 'Title', with: 'My Goal'
    fill_in 'Description', with: 'My Description'
    choose('Private')
    choose('Yes')
    click_button("Add Goal")
    expect(page).to have_content("My Goal")
  end
end
