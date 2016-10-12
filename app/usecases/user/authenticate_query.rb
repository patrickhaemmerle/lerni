class User::AuthenticateQuery
    include UseCase
    
    attr_writer :password
    attr_accessor :login, :userid
    
    def perform
        unless valid? then return end
        
        user = User.find_by_login @login
        if user and user.authenticate @password
            @userid = user.id
        else
            @userid = nil
            errors.add(:login_failed, "Login failed")
        end
    end 
    
end