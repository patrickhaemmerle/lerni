require 'test_helper'

class BoxesControllerTest < ActionController::TestCase
  
  setup do
    login users(:one)  
    @default_post_index = {box_create_box_action: {name: "mybox"}}
  end
  
  test "index get - should redirect if not logged in" do
    logout
    get :index
    assert_redirected_to auth_login_path
  end
  
  test "index" do
    get :index
    assert_response :success
  end
  
  test "index assigns correct boxes" do
    get :index
    assert_equal 2, assigns(:boxes).count
    assigns(:boxes).each do | box |
      assert_equal users(:one).id, box[:user_id]
    end
  end
  
  test "new should redirect if not logged in" do
    logout
    post :new, @default_post_index
    assert_redirected_to auth_login_path
  end
  
  test "new" do
    get :new
    assert_response :success
  end
  
  test "new assigns Box::CreateBoxAction" do
    get :new
    assert assigns(:create_box_action).is_a? Box::CreateBoxAction
  end
  
  test "create should redirect if not logged in" do
    logout
    post :create, @default_post_index
    assert_redirected_to auth_login_path
  end
  
  test "create should create box" do
    assert_difference "users(:one).boxes.count" do
      post :create, @default_post_index
    end
    assert_redirected_to boxes_path
  end
  
  test "create with blank name leads to error" do
    @default_post_index[:box_create_box_action][:name] = "  "
    assert_no_difference "users(:one).boxes.count" do
      post :create, @default_post_index
    end
    assert_response :success
    assert_template "new"
  end

end
