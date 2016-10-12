module AuthenticationHelper
    
    def current_user
        begin
            return User.find(session[:userid])
        rescue
            return nil
        end
    end
    
    def logged_in?
        if session[:userid] && current_user
            return true
        else
            return false
        end
    end
    
end
