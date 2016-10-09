class Auth::SignupController < ApplicationController
  
  def index
    @signup = User::SignupAction.new
  end

  def signup
    input = params.require(:user_signup_action).permit(:login, :password, 
      :password_confirmation, :firstname, :lastname, :email)
    
    @signup = User::SignupAction.perform(input)
    
    if @signup.success?
      flash[:success] = "Welcome, you successfully signed up!"
      redirect_to root_path
    else
      render :index
    end
  end
  
end
