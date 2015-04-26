require 'test_helper'

class AssetCategoriesControllerTest < ActionController::TestCase
  setup do
    @asset_category = asset_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asset_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset_category" do
    assert_difference('AssetCategory.count') do
      post :create, asset_category: { name: @asset_category.name }
    end

    assert_redirected_to asset_category_path(assigns(:asset_category))
  end

  test "should show asset_category" do
    get :show, id: @asset_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asset_category
    assert_response :success
  end

  test "should update asset_category" do
    patch :update, id: @asset_category, asset_category: { name: @asset_category.name }
    assert_redirected_to asset_category_path(assigns(:asset_category))
  end

  test "should destroy asset_category" do
    assert_difference('AssetCategory.count', -1) do
      delete :destroy, id: @asset_category
    end

    assert_redirected_to asset_categories_path
  end
end
