module Notes
    class ListOperation < Operation
      DEFAULT_PAGE_VALUE = 1
      DEFAULT_PER_PAGE_VALUE = 30      
  
      step :validate_contract
      step :build_request_params
      step :list
      step :result

      def validate_contract(context)
        if context[:contract].success?
          Success(context)
        else
          Failure(:invalid_contract)
        end
      end
  
      def build_request_params(context)
        contract = context[:contract]        
        contract.values[:page] = DEFAULT_PAGE_VALUE if !contract.key?(:page)
        contract.values[:per_page] = DEFAULT_PER_PAGE_VALUE if !contract.key?(:per_page)                
        Success(context)
      end
  
      def list(context)
        contract = context[:contract]
        current_user = context[:current_user]
        contract[:notes] = current_user.notes.page(context[:contract][:page]).per(context[:contract][:per_page])
      end
  
      def result(context)        
        notes = context[:notes]        
        result = {page: context[:contract][:page], repositories: repositories_list}
        Success(result)
      end
    end
  end