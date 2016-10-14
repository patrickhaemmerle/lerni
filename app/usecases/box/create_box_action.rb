class Box::CreateBoxAction
    include UseCase
    
    attr_reader :box_id
    attr_accessor :user_id, :name
    
    validates :name, presence: true
    
    validate do
        unless User.exists? user_id
            errors.add :user_id
        end
     end
    
    def perform
        unless valid? then return end
        box = Box.create user_id: user_id, name: name
        unless box
            errors.add :generic, "Box could not be created!"
        end
        @box_id = box.id
    end 
end