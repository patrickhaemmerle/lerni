module AuthenticationHelper
    
    def current_user
        begin
            return User.find(session[:userid])
        rescue
            return nil
        end
    end
    
    def login userid
        session[:userid] = userid
        unless current_user
            logout
        end
    end
    
    def logout
        session[:userid] = nil 
    end
    
    def logged_in?
        if session[:userid] && current_user
            return true
        else
            return false
        end
    end
    
end
