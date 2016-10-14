require 'test_helper'

class BoxTest < ActiveSupport::TestCase
  test "get user" do
    assert_equal users(:one), boxes(:one).user
  end
end
