class User::SignupAction
     include UseCase
     
     attr_reader :id
     attr_accessor :firstname, :lastname, :login, :email, 
          :password, :password_confirmation
          
     validates :login, length: {minimum: 5}
     validates :password, confirmation: true, 
          format: {with: /\A(?=.*[A-Za-z])(?=.*[0-9])(?=.*[^a-zA-Z\d\s]).{6,}\z/}
     validates :password_confirmation, presence: true
     
     # Please have a look at the following link to know why we do not do more
     # sophisticated validations here:
     # https://davidcel.is/posts/stop-validating-email-addresses-with-regex/
     validates :email, format: {with: /\A(.*@.*)?\z/}, presence: false
     
     validate do
         if User.find_by_login(login) 
            errors.add :login, "Login already exists!"
         end
     end
     
     def perform
          unless valid?
               @password = ""
               @password_confirmation = ""
               return
          end
          
          user = User.new
          user.firstname = firstname
          user.lastname = lastname
          user.login = login
          
          if email && email.length == 0
               user.email = nil 
          else 
               user.email = email
          end
          
          user.password = password
          user.password_confirmation = password_confirmation
          
          @password = ""
          @password_confirmation = ""
          
          if user.save
               @id = user.id
          else
               errors.add(:base, "Failed to save user!");
          end
     end
     
end