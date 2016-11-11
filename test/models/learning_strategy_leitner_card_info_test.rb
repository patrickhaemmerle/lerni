require 'test_helper'

class LearningStrategyLeitnerCardInfoTest < ActiveSupport::TestCase
  
  test "get card" do
    cardInfo = learning_strategy_leitner_card_infos(:one)
    assert_equal cards(:one), cardInfo.card
  end
  
  test "removing card also removes card_info" do
    assert_difference "LearningStrategyLeitnerCardInfo.count", -1 do
      cards(:one).destroy
    end
    assert_raise do
      LearningStrategyLeitnerCardInfo.find(learning_strategy_leitner_card_infos(:one).id)
    end
  end
end
