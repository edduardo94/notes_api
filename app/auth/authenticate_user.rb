# frozen_string_literal: true

# app/auth/authenticate_user.rb
class AuthenticateUser
    def call(email, password)
      user = user(email, password)
      JsonWebToken.encode(user_id: user.id) if user
    end
  
    private
  
    attr_reader :email, :password
  
    def user(email, password)
      user = User.find_by(email: email)
      return user if user&.authenticate(password)
  
      raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
  end