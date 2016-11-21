class LearningStrategy::Leitner < LearningStrategy::Base
    
    def initialize
        @interval = []
        @interval[1] = 1
        @interval[2] = 3
        @interval[3] = 10
        @interval[4] = 30
        @interval[5] = 90
        
        @time_condition = ""
        @time_condition += "(compartment = 1 AND last_seen < now() - interval '" + @interval[1].to_s + " day')"
        @time_condition += " OR "
        @time_condition += "(compartment = 2 AND last_seen < now() - interval '" + @interval[2].to_s + " days')"
        @time_condition += " OR "
        @time_condition += "(compartment = 3 AND last_seen < now() - interval '" + @interval[3].to_s + " days')"
        @time_condition += " OR "
        @time_condition += "(compartment = 4 AND last_seen < now() - interval '" + @interval[4].to_s + " days')"
        @time_condition += " OR "
        @time_condition += "(compartment = 5 AND last_seen < now() - interval '" + @interval[5].to_s + " days')"
        
        @time_condition = "(" + @time_condition + ")" 
    end
    
    def hasMoreCardsToLearn box_id
        box = Box.find box_id
        update_index(box)
        
        infos = LearningStrategyLeitnerCardInfo.joins("INNER JOIN cards ON card_id = cards.id AND box_id = " + box_id.to_s + " AND " + @time_condition)
        return infos.count > 0
    end
    
    def getNextCardToLearn box_id
       cardInfo = LearningStrategyLeitnerCardInfo.joins("INNER JOIN cards ON card_id = cards.id AND box_id = " + box_id.to_s + " AND " + @time_condition).order(compartment: :asc, last_seen: :asc).first()
       return cardInfo.card_id if cardInfo
    end
    
    def actUponCorrectAnswer card_id
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id card_id
        
        return if cardInfo.compartment == 6
        
        cardInfo.compartment += 1 unless (DateTime.now - @interval[cardInfo.compartment].days < cardInfo.last_seen)
        cardInfo.last_seen = DateTime.now
        cardInfo.save
    end
    
    def actUponWrongAnswer card_id
        cardInfo = LearningStrategyLeitnerCardInfo.find_by_card_id card_id
        
        return if cardInfo.compartment == 6
        
        cardInfo.compartment = 1
        cardInfo.last_seen = DateTime.now
        cardInfo.save
    end
    
private
    
    def update_index box
        #TODO Maybe this could be optimized to be faster
        cards = box.cards
        cards.each do | card |
            unless LearningStrategyLeitnerCardInfo.find_by_card_id card.id
               LearningStrategyLeitnerCardInfo.create card_id: card.id, compartment: 1, last_seen: "01-01-1970"
            end
        end
    end
    
end