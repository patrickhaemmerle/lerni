class User::LogoutAction
    include UseCase
    
    attr_accessor :sess
    validates :sess, presence: true
    
    def perform
        unless valid? then return end
        @sess[:userid] = nil
    end 
end