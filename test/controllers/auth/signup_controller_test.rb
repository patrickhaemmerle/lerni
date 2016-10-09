require 'test_helper'

class Auth::SignupControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "redirect upon successful signup" do
    assert_difference ("User.count") do
      post :signup, user_signup_action: {firstname: "Firstname", lastname: "Lastname", 
        login: "user9999", email: "user9999@localhost.local", 
        password: "myPass1!", password_confirmation: "myPass1!"}
    end
    assert flash[:success]
    assert_redirected_to root_path
  end
  
  test "show form again if error" do
    assert_no_difference ("User.count") do
      post :signup, user_signup_action: {firstname: "Firstname", lastname: "Lastname", 
        login: "user9999", email: "user9999@localhost.local", 
        password: "myPass1!", password_confirmation: "myPass1!a"}
    end
    assert_template :index
  end

end
