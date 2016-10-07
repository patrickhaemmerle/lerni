class User::SignupActionTest < ActiveSupport::TestCase
    
    setup do
        @user_hash = {login: "us999", firstname: "First",
                lastname: "Last", email: "us999@localhost.local",
                password: "myPass1!", password_confirmation: "myPass1!"}
    end
    
    test "successful signup" do
        result = nil
        assert_difference "User.count" do
            result = User::SignupAction.perform @user_hash
        end
        assert result.success?
        
        user = User.find(result.id)
        assert user
        assert_equal "First", user.firstname
        assert_equal "Last", user.lastname
        assert_equal "us999", user.login
        assert_equal "us999@localhost.local", user.email
        assert user.authenticate "myPass1!"
    end
    
    test "login with less than 5 characters leads to error" do
        result = nil
        @user_hash[:login] = "user"
        assert_no_difference "User.count" do
            result = User::SignupAction.perform @user_hash
        end
        assert_not result.success?
        assert_equal 1, result.errors.count
        assert result.errors[:login]
    end
    
    test "a login that already exists leads to error" do
       result = nil
        @user_hash[:login] = users(:one).login
        assert_no_difference "User.count" do
            result = User::SignupAction.perform @user_hash
        end
        assert_not result.success?
        assert_equal 1, result.errors.count
        assert result.errors[:login]
    end
    
    test "do not accept email address without an @" do
        result = nil
        @user_hash[:email] = "not an email"
        assert_no_difference "User.count" do
            result = User::SignupAction.perform @user_hash
        end
        assert_not result.success?
        assert_equal 1, result.errors.count
        assert result.errors[:email]
    end
    
    test "blank email will result in nil" do
        result = nil
        @user_hash[:email] = ""
        assert_difference "User.count" do
            result = User::SignupAction.perform @user_hash
        end
        assert result.success?
        assert_equal nil, User.find(result.id).email
    end
    
    test "nil email is ok" do
        result = nil
        @user_hash[:email] = nil
        assert_difference "User.count" do
            result = User::SignupAction.perform @user_hash
        end
        assert result.success?
        assert_equal nil, User.find(result.id).email
    end
    
    test "not matching password confirmation leads to error" do
       result = nil
        @user_hash[:password] += "1"
        assert_no_difference "User.count" do
            result = User::SignupAction.perform @user_hash
        end
        assert_not result.success?
        assert_equal 1, result.errors.count
        assert result.errors[:password_confirmation]
    end
    
    test "password fields are empty after any error" do
        @user_hash[:login] = "u"
        result = User::SignupAction.perform @user_hash
        assert_not result.success?
        assert_equal "", result.password
        assert_equal "", result.password_confirmation
    end
    
    test "password fields are empty after successful perform" do
        result = User::SignupAction.perform @user_hash
        assert result.success?
        assert_equal "", result.password
        assert_equal "", result.password_confirmation
    end
    
    test "password with less than 6 characters leads to error" do
        @user_hash[:password] = "u12!A"
        @user_hash[:password_confirmation] = "u12!A"
        result = User::SignupAction.perform @user_hash
        assert_not result.success?
        assert result.errors.details[:password]
    end
    
    test "password without letters leads to error" do
        @user_hash[:password] = "123!56"
        @user_hash[:password_confirmation] = "123!56"
        result = User::SignupAction.perform @user_hash
        assert_not result.success?
        assert result.errors.details[:password] 
    end
    
    test "password without digit leads to error" do
        @user_hash[:password] = "!abcdef"
        @user_hash[:password_confirmation] = "!abcdef"
        result = User::SignupAction.perform @user_hash
        assert_not result.success?
        assert result.errors.details[:password] 
    end
    
    test "password without special symbol leads to error" do
        @user_hash[:password] = "123a56B"
        @user_hash[:password_confirmation] = "123a56B"
        result = User::SignupAction.perform @user_hash
        assert_not result.success?
        assert result.errors.details[:password] 
    end
end