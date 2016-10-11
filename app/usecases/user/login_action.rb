class User::LoginAction
    include UseCase
    
    attr_writer :password, :sess
    attr_accessor :login
    
    def perform
        unless valid? then return end
        
        user = User.find_by_login @login
        if user and user.authenticate @password
            @sess[:userid] = user.id
        else
            @sess[:userid] = nil
            errors.add(:login_failed, "Login failed")
        end
    end 
end