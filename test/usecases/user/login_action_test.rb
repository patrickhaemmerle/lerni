class User::LoginActionTest < ActiveSupport::TestCase
    
    setup do
        @session = {}
        @default_params = {login: "us999", password: "myPass1!", sess: @session}
        
        @user = User.create login: "us999", firstname: "First",
                lastname: "Last", email: "us999@localhost.local",
                password: "myPass1!", password_confirmation: "myPass1!"
    end
    
    test "successful login" do
        result = User::LoginAction.perform @default_params
        assert result.success?
        assert_equal @user.id, @session[:userid]
    end
    
    test "unsuccessful login - wrong password" do
        @default_params[:password] = "boo"
        result = User::LoginAction.perform @default_params
        assert_not result.success?
        assert_equal nil, @session[:userid]
    end
    
    test "unsuccessful login - user not exists" do
        @default_params[:login] = "user999xxx999"
        result = User::LoginAction.perform @default_params
        assert_not result.success?
        assert_equal nil, @session[:userid]
    end
    
end