require 'test_helper'

class ReportIssueControllerTest < ActionController::TestCase
  test "should get choose_room" do
    get :choose_room
    assert_response :success
  end

  test "should get choose_asset_category" do
    get :choose_asset_category
    assert_response :success
  end

  test "should get choose_asset" do
    get :choose_asset
    assert_response :success
  end

  test "should get describe" do
    get :describe
    assert_response :success
  end

  test "should get thank_you" do
    get :thank_you
    assert_response :success
  end

  test "should get how_to" do
    get :how_to
    assert_response :success
  end

end
