require "application_system_test_case"

class FamiliesTest < ApplicationSystemTestCase
  setup do
    @family = families(:one)
  end

  test "visiting the index" do
    visit families_url
    assert_selector "h1", text: "Families"
  end

  test "should create family" do
    visit families_url
    click_on "New family"

    fill_in "Address", with: @family.address
    fill_in "Email", with: @family.email
    fill_in "Holiday", with: @family.holiday
    fill_in "Household caregivers count", with: @family.household_caregivers_count
    fill_in "Household children count", with: @family.household_children_count
    fill_in "Name", with: @family.name
    fill_in "Phone", with: @family.phone
    fill_in "Slug", with: @family.slug
    check "Wrap gifts" if @family.wrap_gifts
    click_on "Create Family"

    assert_text "Family was successfully created"
    click_on "Back"
  end

  test "should update Family" do
    visit family_url(@family)
    click_on "Edit this family", match: :first

    fill_in "Address", with: @family.address
    fill_in "Email", with: @family.email
    fill_in "Holiday", with: @family.holiday
    fill_in "Household caregivers count", with: @family.household_caregivers_count
    fill_in "Household children count", with: @family.household_children_count
    fill_in "Name", with: @family.name
    fill_in "Phone", with: @family.phone
    fill_in "Slug", with: @family.slug
    check "Wrap gifts" if @family.wrap_gifts
    click_on "Update Family"

    assert_text "Family was successfully updated"
    click_on "Back"
  end

  test "should destroy Family" do
    visit family_url(@family)
    click_on "Destroy this family", match: :first

    assert_text "Family was successfully destroyed"
  end
end
