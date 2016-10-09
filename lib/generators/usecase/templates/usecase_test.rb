class <%= class_name %>Test < ActiveSupport::TestCase
    
    setup do
        @default_params = {}
    end
    
    test "successful call" do
        result = nil
        result = <%= class_name %>.perform @default_params
        assert result.success?
    end
    
end