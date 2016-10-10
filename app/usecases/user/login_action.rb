class User::LoginAction
    include UseCase
    
    #attr_reader: return_value
    attr_writer :password, :sess
    attr_accessor :login
    
    #validates :param1, presence: true
    
    validate do
        # custom validations go here
     end
    
    def perform
        user = User.find_by_login @login
        if user and user.authenticate @password
            @sess[:login] = {}
            @sess[:userid] = user.id
        else
            @sess[:userid] = nil
            errors.add(:login_failed, "Login failed")
        end
    end 
end