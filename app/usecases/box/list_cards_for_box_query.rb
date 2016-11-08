class Box::ListCardsForBoxQuery
    include UseCase
    
    attr_reader :cards, :box
    attr_accessor :box_id, :user_id
    
    validates :user_id, presence: true
    validates :box_id, presence: true
    
    validate do
        unless User.exists? @user_id
            errors.add(:user_id)
        end
        
        unless Box.exists?(@box_id) && Box.find(@box_id).user_id == @user_id
            errors.add(:box_id)
        end
    end
    
    def perform
        unless valid? then return end
        
        box = Box.find(@box_id)
        
        @box = {id: box.id,  user_id: box.user_id, name: box.name}
        
        @cards = []
        box.cards.each do |card| 
           @cards << {id: card.id, box_id: card.box_id, front: card.front, back: card.back} 
        end
    
    end 
end