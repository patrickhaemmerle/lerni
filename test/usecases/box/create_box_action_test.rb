class Box::CreateBoxActionTest < ActiveSupport::TestCase
    
    setup do
        @default_params = {user_id: users(:one).id, name: "My New Box"}
    end
    
    test "successful call" do
        result = nil
        assert_difference "Box.count" do
            result = Box::CreateBoxAction.perform @default_params
        end
        assert result.success?
        box = Box.find(result.box_id)
        assert_equal @default_params[:user_id], box.user.id
        assert_equal @default_params[:name], box.name
    end
    
    test "nil name leads to error" do
        result = nil
        @default_params[:name] = nil
        assert_no_difference "Box.count" do
            result = Box::CreateBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors[:name]
    end
    
    test "blank name leads to error" do
        result = nil
        @default_params[:name] = "  "
        assert_no_difference "Box.count" do
            result = Box::CreateBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors[:name]
    end
    
    test "duplicate names are ok" do
        result = nil
        assert_difference "Box.count", 2 do
            result = Box::CreateBoxAction.perform @default_params
            result = Box::CreateBoxAction.perform @default_params
        end
        assert result.success?
    end
    
    test "no userid leads to error" do
        result = nil
        @default_params[:user_id] = nil
        assert_no_difference "Box.count" do
            result = Box::CreateBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors[:user_id]
    end
    
    test "invalid userid leads to error" do
        result = nil
        @default_params[:user_id] = 9876554
        assert_no_difference "Box.count" do
            result = Box::CreateBoxAction.perform @default_params
        end
        assert_not result.success?
        assert result.errors[:user_id]
    end
    
end