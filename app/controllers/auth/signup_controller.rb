class Auth::SignupController < ApplicationController
  
  skip_before_filter :login_required, :only => [:index, :signup]
  
  def index
    @signup = User::SignupAction.new
  end

  def signup
    input = params.require(:user_signup_action).permit(:login, :password, 
      :password_confirmation, :firstname, :lastname, :email)
    
    @signup = User::SignupAction.perform(input)
    
    if @signup.success?
      session[:userid] = @signup.id
      flash[:success] = "Welcome, you successfully signed up!"
      redirect_to boxes_path
    else
      render :index
    end
  end
  
end
