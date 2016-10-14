class Box::ListBoxesForUserQuery
    include UseCase
    
    attr_reader :boxes
    attr_accessor :user_id
    
    validates :user_id, presence: true
    
    validate do
        # custom validations go here
     end
    
    def perform
        unless valid? then return end
        @boxes = []
        Box.where(user_id: user_id).each do | box |
            @boxes << {
                box_id: box.id,
                user_id: box.user_id,
                name: box.name
            }
        end
    end 
end