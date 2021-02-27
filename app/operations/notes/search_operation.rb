module Notes
    class SearchOperation < Operation
      include Dry::Transaction
      DEFAULT_PAGE_VALUE = 1
      DEFAULT_PER_PAGE_VALUE = 10

      step :validate_contract
      step :build_request_params
      step :search
      step :result


      def build_request_params(context)
        contract = context[:contract]
        contract.values[:page] = DEFAULT_PAGE_VALUE if !contract.key?(:page)
        contract.values[:per_page] = DEFAULT_PER_PAGE_VALUE if !contract.key?(:per_page)
        query =""
        if !context[:contract][:title].nil?
          query = "title like '%#{context[:contract][:title]}%'"
        end

        if !context[:contract][:description].nil?
          if !query.nil?
            query = query + " or "
          end
          query = query + "description like '%#{context[:contract][:description]}%'"
        end

        context[:query] = query
        Success(context)
      end

      def search(context)
        contract = context[:contract]
        current_user = context[:current_user]
        notes = current_user.notes.where(context[:query])
        .page(context[:contract][:page]).per(context[:contract][:per_page])
        if notes.nil?
          Failure(:not_found)
        else
          context[:notes] = notes
          Success(context)
        end
      end

      def result(context)
        notes = context[:notes]
        result = {page: context[:contract][:page], notes: notes}
        Success(result)
      end
    end
  end