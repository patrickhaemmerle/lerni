class LearningStrategy::LearningStrategyInterfaceTest < ActiveSupport::TestCase
    
    test "hasMoreCardsToLearn returns false for empty box" do
        return unless realtest
        assert_not get_strategy.hasMoreCardsToLearn boxes(:three).id
    end
    
    test "hasMoreCardsToLearn returns false if there are no more cards to learn" do
        return unless realtest
        populate_with_cards_not_to_learn
        assert_not get_strategy.hasMoreCardsToLearn boxes(:three).id
    end
    
    test "hasMoreCardsToLearn returns true if there is a card to learn" do
        return unless realtest
        populate_with_one_card_to_learn
        assert get_strategy.hasMoreCardsToLearn boxes(:three).id
    end
    
    test "getNextCardToLearn returns card_id if there is a card" do
        return unless realtest
        card = populate_with_one_card_to_learn
        assert_equal card.id, get_strategy.getNextCardToLearn(card.box_id)
    end
    
    test "getNextCardToLearn returns nil if there is no card to learn" do
        return unless realtest
        populate_with_cards_not_to_learn
        assert_nil get_strategy.getNextCardToLearn boxes(:three).id
    end
    
    test "getNextCardToLearn returns nil if box is empty" do
        return unless realtest
        assert_nil get_strategy.getNextCardToLearn boxes(:three).id
    end
   
    private
    
    def realtest
        real = !(self.class.name == "LearningStrategy::LearningStrategyInterfaceTest")
        return unless real
        assert respond_to? "get_strategy"
        assert respond_to? "populate_with_cards_not_to_learn"
        assert respond_to? "populate_with_one_card_to_learn"
        return real
    end
    
end