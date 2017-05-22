require 'spec_helper'

describe('shoe_path', :type => :feature) do
  it "adds shoes and associates them with brands" do
    visit('/')
    within "#brand" do
      fill_in("name", with: "Nike")
      fill_in("price", with: "$120")
    end
    click_button("Add brand")
    expect(page).to have_content('Nike')
    within "#store" do
      fill_in("name", with: "Nordstrom")
    end
    click_button("Add store")
    expect(page).to have_content('Nordstrom')
  end
end
