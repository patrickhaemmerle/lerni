require 'test_helper'

class BoxTest < ActiveSupport::TestCase
  test "get user" do
    assert_equal users(:one), boxes(:one).user
  end
  
  test "get cards" do
    cards = boxes(:one).cards
    assert_equal 2, cards.count
    cards.each do |card|
      assert_equal boxes(:one).id, card.box_id      
    end
  end
  
end
