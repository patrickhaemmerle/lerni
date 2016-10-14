require 'test_helper'

class TestableController < ApplicationController
  def index
    render :text => 'rendered content here', :status => 200
  end
end

class ApplicationControllerTest < ActionController::TestCase
  
  tests TestableController
  
  setup do
    Rails.application.routes.draw do
      get 'base' => 'testable#index'
    end
  end
  
  teardown do
    Rails.application.routes_reloader.reload!
  end
  
  test "current_user if nil" do
    session[:userid] = nil
    get :index
    assert_nil assigns(:current_user)
  end
  
  test "current_user if invalid" do
    session[:userid] = 333999
    get :index
    assert_nil assigns(:current_user)
  end
  
  test "current_user if valid user logged in" do
    session[:userid] = users(:one).id
    get :index
    assert_equal users(:one).id, assigns(:current_user)[:id]
    assert_equal users(:one).login, assigns(:current_user)[:login]
    assert_equal users(:one).firstname, assigns(:current_user)[:firstname]
    assert_equal users(:one).lastname, assigns(:current_user)[:lastname]
    assert_equal users(:one).email, assigns(:current_user)[:email]
  end
  
  test "login required ok when logged in" do
    session[:userid] = users(:one).id
    get :index
    assert_response :success
  end

  test " login required redirects to login page if no user logged in" do
    session[:userid] = nil
    get :index
    assert_redirected_to '/auth/login'
  end
  
  test " login required redirects to login page if user in session is invalid" do
    session[:userid] = 333999
    get :index
    assert_redirected_to '/auth/login'
  end

end
