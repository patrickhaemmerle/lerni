class Auth::LoginController < ApplicationController
  
  def index
    @login = User::LoginAction.new
  end
  
  def login
    login = params[:user_login_action][:login]
    password = params[:user_login_action][:password]
    result = User::LoginAction.perform login: login, password: password, sess: session
    if result.success?
      redirect_to root_path
    else
      flash.now[:error] = "Login failed, please try again!"
      @login = result
      render 'index'
      #redirect_to auth_login_path
    end
  end
  
end
