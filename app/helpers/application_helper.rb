module ApplicationHelper

    def current_user
        begin
            return User.find(session[:userid])
        rescue
            return nil
        end
    end

end
