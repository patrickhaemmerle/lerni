class User::AuthenticateQueryTest < ActiveSupport::TestCase
    
    setup do
        @default_params = {login: "us999", password: "myPass1!"}
        
        @user = User.create login: "us999", firstname: "First",
                lastname: "Last", email: "us999@localhost.local",
                password: "myPass1!", password_confirmation: "myPass1!"
    end
    
    test "successful login" do
        result = User::AuthenticateQuery.perform @default_params
        assert result.success?
        assert_equal @user.id, result.userid
    end
    
    test "unsuccessful login - wrong password" do
        @default_params[:password] = "boo"
        result = User::AuthenticateQuery.perform @default_params
        assert_not result.success?
        assert_equal nil, result.userid
    end
    
    test "unsuccessful login - user not exists" do
        @default_params[:login] = "user999xxx999"
        result = User::AuthenticateQuery.perform @default_params
        assert_not result.success?
        assert_equal nil, result.userid
    end
    
    test "blank login leads to error" do
         @default_params[:login] = ""
        result = User::AuthenticateQuery.perform @default_params
        assert_not result.success?
        assert_equal nil, result.userid
    end
    
    test "nil login leads to error" do
         @default_params[:login] = nil
        result = User::AuthenticateQuery.perform @default_params
        assert_not result.success?
        assert_equal nil, result.userid
    end
    
    test "nil password leads to error" do
         @default_params[:password] = ""
        result = User::AuthenticateQuery.perform @default_params
        assert_not result.success?
        assert_equal nil, result.userid
    end
    
    test "does not expose password" do
        result = User::AuthenticateQuery.perform @default_params
        assert_raises NoMethodError do
            result.password
        end
    end
    
end