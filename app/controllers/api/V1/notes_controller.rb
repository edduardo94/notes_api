module Api
    module V1
        class NotesController < ApplicationController
            skip_before_action :verify_authenticity_token

            def create
              Notes::CreateOperation.new.call(create_dependencies) do |op|
                op.success do |context|
                  render json: context, status: 200
                end

                op.failure :validate_contract do |failure|
                  contract = Notes::CreateContract.new.(params)
                  render json: {code: 400,
                                status: Message.bad_request,
                                error: contract.errors}, status: 400
                end

              end
            end

            def update
              Notes::UpdateOperation.new.call(update_dependencies) do |op|
                op.success do |context|
                  render json: context, status: 200
                end

                op.failure :validate_contract do |failure|
                  contract = Notes::UpdateContract.new.(params)
                  render json: {code: 400,
                                status: Message.bad_request,
                                error: contract.errors}, status: 400
                end

                op.failure do |failure|
                  render json: {code: 404,
                                status: Message.not_found('note'),
                                error: failure}, status: 404
                end
              end
            end

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

          def search
            Notes::SearchOperation.new.call(search_dependencies) do |op|
                op.success do |context|
                  render json: context, status: 200
                end

                op.failure :validate_contract do |failure|
                  contract = Notes::SearchContract.new.(params)
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

        def destroy
          Notes::DeleteOperation.new.call(delete_dependencies) do |op|
            op.success do |context|
              render json: context, status: 200
            end

            op.failure :validate_contract do |failure|
              contract = Notes::DeleteContract.new.(params)
              render json: {code: 400,
                            status: Message.bad_request,
                            error: contract.errors}, status: 400
            end

            op.failure do |failure|
              render json: {code: 404,
                            status: Message.not_found('note'),
                            error: failure}, status: 404
            end
          end
        end

        private
        def search_dependencies
          {
            contract: Notes::SearchContract.new.(params),
            current_user: @current_user
          }
        end

        def list_dependencies
          {
            contract: Notes::ListContract.new.(params),
            current_user: @current_user
          }
        end

        def create_dependencies
          {
            contract: Notes::CreateContract.new.(params),
            current_user: @current_user
          }
        end

        def update_dependencies
          {
            contract: Notes::UpdateContract.new.(params),
            current_user: @current_user
          }
        end

        def delete_dependencies
          {
            contract: Notes::DeleteContract.new.(params),
            current_user: @current_user
          }
        end
    end
  end
end