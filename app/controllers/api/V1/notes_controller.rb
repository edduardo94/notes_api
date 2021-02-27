module Api
    module V1
        class NotesController < ApplicationController
            def list
                Notes::ListOperation.new.call(list_dependencies) do |op|                    
                    op.success do |context|
                      render json: context, status: 200
                    end
          
                    op.failure :validate_contract do |failure|
                      contract = Notes::ListContract.new.(params)
                      render json: {code: 400,
                                    status: Message.bad_request,
                                    error: contract.errors}, status: 400
                    end 

                    op.failure do |failure|
                      render json: {code: 404,
                                    status: Message.not_found('notes'),
                                    error: failure}, status: 404
                    end                  
                end
            end


            private
            def search_dependencies
              {
                contract: Notes::SearchContract.new.(params)
              }
            end
      
            def list_dependencies
              {
                contract: Notes::ListContract.new.(params),
                current_user: @current_user
              }
            end
        end
    end
end