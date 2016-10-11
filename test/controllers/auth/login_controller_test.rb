require 'test_helper'

class Auth::LoginControllerTest < ActionController::TestCase
  
  setup do
    @user = User.create login: "us999", firstname: "First",
      lastname: "Last", email: "us999@localhost.local",
      password: "myPass1!", password_confirmation: "myPass1!"
    end
  
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "successful login" do
    post :login, user_login_action: {login: "us999", password: "myPass1!"}
    assert_equal @user.id, session[:userid]    
    assert_redirected_to root_path
  end

  test "failed login" do
    post :login, user_login_action: {login: "us999", password: "myPass1!WRONG"}
    assert_nil session[:userid]    
    assert assert flash[:error]
    assert_template 'index'
  end
  
  test "logout" do
    session[:userid] = 9
    delete :logout
    assert_redirected_to root_path
    assert_nil session[:userid]
  end

end
