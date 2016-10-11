class <%= class_name %>
    include UseCase
    
    #attr_reader :return_value
    #attr_accessor :param1
    
    #validates :param1, presence: true
    
    validate do
        # custom validations go here
     end
    
    def perform
        unless valid? then return end
        # put your implementation here
    end 
end