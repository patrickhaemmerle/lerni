require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test "get box" do
    assert_equal boxes(:one), cards(:one).box
  end
end
