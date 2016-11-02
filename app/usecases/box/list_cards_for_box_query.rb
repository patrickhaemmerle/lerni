class Box::ListCardsForBoxQuery
    include UseCase
    
    attr_reader :cards
    attr_accessor :box_id, :user_id
    
    validates :user_id, presence: true
    validates :box_id, presence: true
    
    validate do
        unless Box.exists? @box_id 
            errors.add(:box_id)
        end
        
        unless User.exists? @user_id
            errors.add(:user_id)
        end
        
        if errors.count == 0
            unless Box.find(@box_id).user_id == @user_id
                errors.add(:box_id)
            end
        end
    end
    
    def perform
        unless valid? then return end
        @cards = Box.find(@box_id).cards
    end 
end