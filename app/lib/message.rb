# app/lib/message.rb
class Message
    def self.not_found(record = 'record')
      "Sorry, #{record} not found."
    end
  
    def self.invalid_credentials
      'Invalid credentials'
    end
  
    def self.invalid_token
      'Invalid token'
    end
  
    def self.missing_token
      'Missing token'
    end
  
    def self.unauthorized
      'Unauthorized request'
    end
  
    def self.account_created
      'Account created successfully'
    end
  
    def self.account_already_exists
      'Conta ja existente'
    end
  
    def self.account_not_created
      'Account could not be created'
    end
  
    def self.expired_token
      'Sorry, your token has expired. Please login to continue.'
    end
  
    def self.bad_request
      "Bad request"
    end
  end