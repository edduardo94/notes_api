class ApplicationController < ActionController::Base
    include Response
    include ExceptionHandler
  
    before_action :params, :authorize_request
    attr_reader :current_user
  
    private
  
    def params
      super.permit!.to_h
    end
  
    def authorize_request
      @current_user = AuthorizeApiRequest.new(request.headers).call[:user]      
    end
  end