require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  
  setup do
    login users(:one)  
    @default_params = {formdata: {front: "myFront", back: "myBack"}, box_id: boxes(:one).id}
  end
  
  test "create should redirect if not logged in" do
    logout
    post :create, @default_params
    assert_redirected_to auth_login_path
  end
  
  test "create should not create card if box is not mine" do 
    @default_params[:box_id] = boxes(:three).id
    assert_no_difference "Card.count" do
      post :create, @default_params
    end
  end
  
  test "create should redirect if box is not mine" do 
    @default_params[:box_id] = boxes(:three).id
    post :create, @default_params
    assert_redirected_to boxes_path
  end

  test "create should create a card" do
    assert_difference "boxes(:one).cards.count" do
      post :create, @default_params
    end
  end

  test "create should redirect after create" do
    post :create, @default_params
    assert_redirected_to boxes_path
  end
  
  test "create generates error then render new" do
    @default_params[:formdata][:front] = nil
    post :create, @default_params
    assert_template :new
  end
  
  test "get new success" do
    get :new, box_id: boxes(:one).id
    assert_response :success
  end
  
  test "get new assigns formdata" do
    get :new, box_id: boxes(:one).id
    assert assigns(:formdata).is_a? Box::AddCardToBoxAction
  end
  
  test "get index redirects if not logged in" do
    logout
    get :index, box_id: boxes(:one).id
    assert_redirected_to auth_login_path
  end
  
  test "get index redirects if box is not mine" do
    get :index, box_id: boxes(:three).id
    assert_redirected_to boxes_path
  end
  
  test "get index is success" do
    get :index, box_id: boxes(:one).id
    assert_response :success
  end
  
  test "get index assigns all cards of the box" do
    get :index, box_id: boxes(:one).id
    assert_equal 2, assigns(:cards).count
    assigns(:cards).each do |card|
      assert_equal boxes(:one).id, card[:box_id]
    end
  end
  
  test "get index assigns empty array for empty box" do
    logout
    login users(:two)
    get :index, box_id: boxes(:three).id
    assert_equal 0, assigns(:cards).count
  end
  
end
