class LearningStrategy::BaseTest < ActiveSupport::TestCase
    
    setup do
        @strategy = LearningStrategy::Base.new
    end
    
    test "hasMoreCardsToLearn raises not implemented" do
        assert_raises NotImplementedError do
            @strategy.hasMoreCardsToLearn 1
        end
    end
    
    test "getNextCardToLearn raises not implemented" do
        assert_raises NotImplementedError do
            @strategy.getNextCardToLearn 1
        end
    end
    
    test "actUponCorrectAnswer raises not implemented" do
        assert_raises NotImplementedError do
            @strategy.actUponCorrectAnswer 1
        end
    end
    
    test "actUponWrongAnswer raises not implemented" do
        assert_raises NotImplementedError do
            @strategy.actUponWrongAnswer 1
        end
    end
    
end