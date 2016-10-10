class User::LogoutActionTest < ActiveSupport::TestCase
    
    setup do
        @default_params = {sess: {userid: 998877}}
    end
    
    test "successful logout" do
        result = User::LogoutAction.perform @default_params
        assert result.success?
        assert_nil @default_params[:sess][:userid]
    end
    
    test "error when session is nil" do
        result = User::LogoutAction.perform {}
        assert_not result.success?
    end
    
    test "error when userid is not in session" do
        @default_params[:sess][:userid] = nil
        @default_params[:sess][:xy] = ""
        result = User::LogoutAction.perform {@default_params}
        assert_not result.success?
    end
    
end