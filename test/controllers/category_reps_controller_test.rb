require 'test_helper'

class CategoryRepsControllerTest < ActionController::TestCase
  setup do
    @category_rep = category_reps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_reps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_rep" do
    assert_difference('CategoryRep.count') do
      post :create, category_rep: { category: @category_rep.category }
    end

    assert_redirected_to category_rep_path(assigns(:category_rep))
  end

  test "should show category_rep" do
    get :show, id: @category_rep
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category_rep
    assert_response :success
  end

  test "should update category_rep" do
    patch :update, id: @category_rep, category_rep: { category: @category_rep.category }
    assert_redirected_to category_rep_path(assigns(:category_rep))
  end

  test "should destroy category_rep" do
    assert_difference('CategoryRep.count', -1) do
      delete :destroy, id: @category_rep
    end

    assert_redirected_to category_reps_path
  end
end
