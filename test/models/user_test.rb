require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "get boxes for user" do
        assert_equal 2, users(:one).boxes.count
    end
end
