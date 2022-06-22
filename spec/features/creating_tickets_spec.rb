require "rails_helper"

RSpec.feature "Users can create new tickets >" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:state) { FactoryBot.create :state, name: "New", default: true }

  before do
    login_as(user)
    project = FactoryBot.create(:project, name: "Internet Explorer")
    visit project_path(project)
    click_link "New Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has been created."
    within(".ticket") do
      expect(page).to have_content "Author: #{user.email}"
      expect(page).to have_content "State: New"
    end
  end

  scenario "when providing invalid attributes" do
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "with an invalid description" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "It sucks"
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Description is too short"
  end

  scenario "with an attachment" do
    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    attach_file "File", "spec/fixtures/speed.txt"
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has been created."
    within(".ticket .attachment") do
      expect(page).to have_content "speed.txt"
    end
  end

  scenario "with associated tags" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    fill_in "Tags", with: "visual testing, browser"
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has been created."
    within(".ticket .tags") do
      expect(page).to have_content "browser"
      expect(page).to have_content "visual testing"
    end
  end
end
