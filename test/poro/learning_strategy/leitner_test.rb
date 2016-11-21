class LearningStrategy::LeitnerTest < LearningStrategy::LearningStrategyInterfaceTest
    
    setup do
        @strategy = LearningStrategy::Leitner.new
    end
    
    test "hasMoreCardsToLearn returns true if box has not yet indexed cards" do
        create_card :card => {}
        assert @strategy.hasMoreCardsToLearn boxes(:three).id
    end
    
    test "hasMoreCardsToLearn returns true if there is a card to learn in compartment 1" do
        populate_with_cards_not_to_learn
        create_card :card => {}, :info => {last_seen: DateTime.now - 24.hours - 1.minutes, compartment: 1}
        assert @strategy.hasMoreCardsToLearn boxes(:three).id
    end
    
    test "hasMoreCardsToLearn returns true if there is a card to learn in compartment 2" do
        populate_with_cards_not_to_learn
        create_card :card => {}, :info => {last_seen: DateTime.now - 3.days - 1.minutes, compartment: 2}
        assert @strategy.hasMoreCardsToLearn boxes(:three).id
    end
    
    test "hasMoreCardsToLearn returns true if there is a card to learn in compartment 3" do
        populate_with_cards_not_to_learn
        create_card :card => {}, :info => {last_seen: DateTime.now - 10.days - 1.minutes, compartment: 3}
        assert @strategy.hasMoreCardsToLearn boxes(:three).id
    end
    
    test "hasMoreCardsToLearn returns true if there is a card to learn in compartment 4" do
        populate_with_cards_not_to_learn
        create_card :card => {}, :info => {last_seen: DateTime.now - 30.days - 1.minutes, compartment: 4}
        assert @strategy.hasMoreCardsToLearn boxes(:three).id
    end
    
    test "hasMoreCardsToLearn returns true if there is a card to learn in compartment 5" do
        populate_with_cards_not_to_learn
        create_card :card => {}, :info => {last_seen: DateTime.now - 90.days - 1.minutes, compartment: 5}
        assert @strategy.hasMoreCardsToLearn boxes(:three).id
    end
    
    test "getNextCardToLearn if there are no more cards to learn" do
        populate_with_cards_not_to_learn
        assert_nil @strategy.getNextCardToLearn(boxes(:three).id)
    end
    
    test "getNextCardToLearn with a card in every compartment" do
        populate_with_cards_not_to_learn
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 24.hours - 1.minute, compartment: 1}
        create_card :card => {}, :info => {last_seen: DateTime.now - 3.days - 1.minute, compartment: 2}
        create_card :card => {}, :info => {last_seen: DateTime.now - 10.days - 1.minute, compartment: 3}
        create_card :card => {}, :info => {last_seen: DateTime.now - 30.days - 1.minute, compartment: 4}
        create_card :card => {}, :info => {last_seen: DateTime.now - 90.days - 1.minute, compartment: 5}
        assert_equal card.id, @strategy.getNextCardToLearn(boxes(:three).id)
    end
    
    test "getNextCardToLearn with a card in every compartment from 2" do
        populate_with_cards_not_to_learn
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 3.days - 1.minute, compartment: 2}
        create_card :card => {}, :info => {last_seen: DateTime.now - 10.days - 1.minute, compartment: 3}
        create_card :card => {}, :info => {last_seen: DateTime.now - 30.days - 1.minute, compartment: 4}
        create_card :card => {}, :info => {last_seen: DateTime.now - 90.days - 1.minute, compartment: 5}
        assert_equal card.id, @strategy.getNextCardToLearn(boxes(:three).id)
    end
    
    test "getNextCardToLearn with a card in every compartment from 3" do
        populate_with_cards_not_to_learn
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 10.days - 1.minute, compartment: 3}
        create_card :card => {}, :info => {last_seen: DateTime.now - 30.days - 1.minute, compartment: 4}
        create_card :card => {}, :info => {last_seen: DateTime.now - 90.days - 1.minute, compartment: 5}
        assert_equal card.id, @strategy.getNextCardToLearn(boxes(:three).id)
    end
    
    test "getNextCardToLearn with a card in every compartment from 4" do
        populate_with_cards_not_to_learn
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 30.days - 1.minute, compartment: 4}
        create_card :card => {}, :info => {last_seen: DateTime.now - 90.days - 1.minute, compartment: 5}
        assert_equal card.id, @strategy.getNextCardToLearn(boxes(:three).id)
    end
    
    test "getNextCardToLearn with a card in compartment 5" do
        populate_with_cards_not_to_learn
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 90.days - 1.minute, compartment: 5}
        assert_equal card.id, @strategy.getNextCardToLearn(boxes(:three).id)
    end
    
    test "actUponCorrectAnswer moves card and updates last_seen from compartment 1" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 1.days - 1.minute, compartment: 1}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 2, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponCorrectAnswer moves card and updates last_seen from compartment 2" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 3.days - 1.minute, compartment: 2}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 3, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponCorrectAnswer moves card and updates last_seen from compartment 3" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 10.days - 1.minute, compartment: 3}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 4, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponCorrectAnswer moves card and updates last_seen from compartment 4" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 30.days - 1.minute, compartment: 4}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 5, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponCorrectAnswer moves card and updates last_seen from compartment 5" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 90.days - 1.minute, compartment: 5}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 6, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponCorrectAnswer does not move card and does not update last_seen from compartment 6" do
        last_seen = DateTime.now - 200.days
        card = create_card :card => {}, :info => {last_seen: last_seen, compartment: 6}
        @strategy.actUponCorrectAnswer card.id
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 6, cardInfo.compartment
        assert_equal last_seen.to_i, cardInfo.last_seen.to_i
    end
    
    test "actUponCorrectAnswer does not move card and updates last_seen if date condition would not allow learning it in compartment 1" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 23.hours - 59.minutes, compartment: 1}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 1, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponCorrectAnswer does not move card and updates last_seen if date condition would not allow learning it in compartment 2" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 2.days - 23.hours - 59.minutes, compartment: 2}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 2, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponCorrectAnswer does not move card and updates last_seen if date condition would not allow learning it in compartment 3" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 9.days - 23.hours - 59.minutes, compartment: 3}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 3, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i 
    end
    
    test "actUponCorrectAnswer does not move card and updates last_seen if date condition would not allow learning it in compartment 4" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 29.days - 23.hours - 59.minutes, compartment: 4}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 4, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponCorrectAnswer does not move card and updates last_seen if date condition would not allow learning it in compartment 5" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 89.days - 23.hours - 59.minutes, compartment: 5}
        @strategy.actUponCorrectAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 5, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i 
    end
    
    test "actUponWrongAnswer does not move card and updates last_seen from compartment 1" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 1.days - 1.minute, compartment: 1}
        @strategy.actUponWrongAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 1, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponWrongAnswer moves card and updates last_seen from compartment 2" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 3.days - 1.minute, compartment: 2}
        @strategy.actUponWrongAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 1, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponWrongAnswer moves card and updates last_seen from compartment 3" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 10.days - 1.minute, compartment: 3}
        @strategy.actUponWrongAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 1, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i 
    end
    
    test "actUponWrongAnswer moves card and updates last_seen from compartment 4" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 30.days - 1.minute, compartment: 4}
        @strategy.actUponWrongAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 1, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i
    end
    
    test "actUponWrongAnswer moves card and updates last_seen from compartment 5" do
        before = DateTime.now
        card = create_card :card => {}, :info => {last_seen: DateTime.now - 90.days - 1.minute, compartment: 5}
        @strategy.actUponWrongAnswer card.id
        after = DateTime.now
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 1, cardInfo.compartment
        assert cardInfo.last_seen.to_i >= before.to_i
        assert cardInfo.last_seen.to_i <= after.to_i 
    end
    
    test "actUponWrongAnswer does not move card and does not update last_seen from compartment 6" do
        last_seen = DateTime.now - 200.days
        card = create_card :card => {}, :info => {last_seen: last_seen, compartment: 6}
        @strategy.actUponWrongAnswer card.id
        
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id(card.id)
        assert_equal 6, cardInfo.compartment
        assert_equal cardInfo.last_seen.to_i, last_seen.to_i
    end
    
    def get_strategy
       @strategy 
    end
    
    def populate_with_cards_not_to_learn
        create_card :card => {}, :info => {last_seen: DateTime.now - 23.hours - 59.minutes, compartment: 1}
        create_card :card => {}, :info => {last_seen: DateTime.now - 2.days - 23.hours - 59.minutes, compartment: 2}
        create_card :card => {}, :info => {last_seen: DateTime.now - 9.days - 23.hours - 59.minutes, compartment: 3}
        create_card :card => {}, :info => {last_seen: DateTime.now - 29.days - 23.hours - 59.minutes, compartment: 4}
        create_card :card => {}, :info => {last_seen: DateTime.now - 89.days - 23.hours - 59.minutes, compartment: 5}
        create_card :card => {}, :info => {last_seen: DateTime.now - 500.days, compartment: 6}
    end
    
    def populate_with_one_card_to_learn
        create_card :card => {}, :info => {last_seen: DateTime.now - 24.hours - 1.minute, compartment: 1}
    end
    
    private
    
    def create_card data
        card_data = data[:card]
        info_data = data[:info]
       
        card_data[:front] = "Front" unless card_data[:front]
        card_data[:back] = "Back" unless card_data[:back]
        card_data[:box_id] = boxes(:three).id unless card_data[:box_id]
        card = Card.create card_data
       
        if info_data
            info_data[:card_id] = card.id
            LearningStrategyLeitnerCardInfo.create info_data 
        end
        return card
    end
    
end