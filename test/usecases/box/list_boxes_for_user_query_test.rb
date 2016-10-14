class Box::ListBoxesForUserQueryTest < ActiveSupport::TestCase
    
    setup do
        @default_params = {user_id: users(:one)}
    end
    
    test "successful call" do
        result = Box::ListBoxesForUserQuery.perform @default_params
        assert result.success?
        assert_equal 2, result.boxes.count
        result.boxes.each do | box |
           assert_equal users(:one).id, box[:user_id]
        end
    end
    
    test "call without user" do
        @default_params[:user_id] = nil
        result = Box::ListBoxesForUserQuery.perform @default_params
        assert_not result.success?
        assert_nil result.boxes
    end
    
    test "call with invalid user" do
        @default_params[:user_id] = 123123
        result = Box::ListBoxesForUserQuery.perform @default_params
        assert result.success?
        assert_equal 0, result.boxes.count
    end
    
end