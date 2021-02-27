module Notes
    class ShowOperation < Operation
      include Dry::Transaction

      step :validate_contract
      step :list
      step :result

      def list(context)
        contract = context[:contract]
        current_user = context[:current_user]
        note = current_user.notes.find_by(id: context[:contract][:id])
        if note.nil?
            Failure(:not_found)
        else
            context[:note] = note
            Success(context)
        end
        Success(context)
      end

      def result(context)
        note = context[:note]
        result = { note: note}
        Success(result)
      end
    end
  end