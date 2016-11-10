class LearningStrategy::Base
    
    def hasMoreCardsToLearn box_id
        raise NotImplementedError
    end
    
    def getNextCardToLearn box_id
       raise NotImplementedError 
    end
    
    def actUponCorrectAnswer card_id
        raise NotImplementedError 
    end
    
    def actUponWrongAnswer card_id
        raise NotImplementedError 
    end
    
end