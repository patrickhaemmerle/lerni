class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :current_user, :login_required
  
  private
  
  def login_required
    if @current_user == nil 
      redirect_to '/auth/login'
    end
  end
  
  def current_user
    begin
      user = User.find(session[:userid])
      @current_user = {
        id: user.id,
        login: user.login,
        firstname: user.firstname,
        lastname: user.lastname,
        email: user.email
      }
    rescue
      @current_user = nil
    end
  end
  
end
