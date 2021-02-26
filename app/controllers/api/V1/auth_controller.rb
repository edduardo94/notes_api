module Api
  module V1
    class AuthController < ApplicationController
      skip_forgery_protection
      skip_before_action :authorize_request

      def authenticate
        Auth::AuthOperation.new.call(auth_dependencies) do |o|
          o.success do |context|
            render json: context, status: 200
          end

          o.failure :validate_contract do |_e|
            contract = Auth::AuthContract.new.call(params)
            render json: { code: 400, error: contract.errors }, status: 400
          end

          o.failure :authenticate do |error|
            render json: { code: 401, error: error }, status: 401
          end
        end
      end

      private

      def auth_dependencies
        {
          contract: Auth::AuthContract.new.call(params),
          auth: AuthenticateUser
        }
      end
    end
  end
end
