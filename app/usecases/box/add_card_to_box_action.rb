class Box::AddCardToBoxAction
    include UseCase
    
    attr_reader :card_id
    attr_accessor :front, :back, :box_id, :user_id
    
    validates :front, presence: true
    validates :back, presence: true
    
    validate do
        user_exists = User.exists? user_id
        box_exists = Box.exists? box_id
        unless user_exists
            errors.add :user_id
        end
        
        unless box_exists
            errors.add :box_id
        else
            if user_exists && Box.find(box_id).user_id != user_id
                errors.add :box_id
            end
        end
     end
    
    def perform
        unless valid? then return end
        card = Card.create front: front, back: back, box_id: box_id
        @card_id = card.id
    end 
end