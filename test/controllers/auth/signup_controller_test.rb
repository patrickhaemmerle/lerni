require 'test_helper'

class Auth::SignupControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "user is created upon successful signup" do
    assert_difference ("User.count") do
      post :signup, user_signup_action: {firstname: "Firstname", lastname: "Lastname", 
        login: "user9999", email: "user9999@localhost.local", 
        password: "myPass1!", password_confirmation: "myPass1!"}
    end
  end
  
  test "redirect upon successful signup" do
    post :signup, user_signup_action: {firstname: "Firstname", lastname: "Lastname", 
      login: "user9999", email: "user9999@localhost.local", 
      password: "myPass1!", password_confirmation: "myPass1!"}
    assert_redirected_to boxes_path
  end
  
  test "flash upon successful signup" do
    post :signup, user_signup_action: {firstname: "Firstname", lastname: "Lastname", 
      login: "user9999", email: "user9999@localhost.local", 
      password: "myPass1!", password_confirmation: "myPass1!"}
    assert flash[:success]
  end
  
  test "user is logged in after successful signup" do
    post :signup, user_signup_action: {firstname: "Firstname", lastname: "Lastname", 
      login: "user9999", email: "user9999@localhost.local", 
      password: "myPass1!", password_confirmation: "myPass1!"}
    assert session[:userid]
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
