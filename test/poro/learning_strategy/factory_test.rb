class LearningStrategy::FactoryTest < ActiveSupport::TestCase
    
    test "responds to class method createLearningStrategy" do
        LearningStrategy::Factory.createLearningStrategy boxes(:one).id
    end
    
    test "return a LearningStrategy::Leitner as default" do
        strategy = LearningStrategy::Factory.createLearningStrategy boxes(:one).id
        assert strategy.is_a? LearningStrategy::Leitner
    end
    
end