class Auth::LoginController < ApplicationController
  
  skip_before_filter :login_required, :only => [:index, :login]
  
  def index
    @login = User::AuthenticateQuery.new
  end
  
  def login
    login = params[:user_authenticate_query][:login]
    password = params[:user_authenticate_query][:password]
    result = User::AuthenticateQuery.perform login: login, password: password
    if result.success?
      session[:userid] = result.userid
      redirect_to root_path
    else
      session[:userid] = nil
      flash.now[:error] = "Login failed, please try again!"
      @login = result
      render 'index'
    end
  end
  
  def logout
    session[:userid] = nil    
    redirect_to root_path
  end
  
end
