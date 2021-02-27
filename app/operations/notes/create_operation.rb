module Notes
    class CreateOperation < Operation
        include Dry::Transaction

        step :validate_contract
        step :execute_query
        step :result

        def execute_query(context)
            contract = context[:contract]
            current_user = context[:current_user]
            note = current_user.notes.new(title: contract[:title], description: contract[:description])
            if note.save!
                context[:note] = note
                Success(context)
            else
                Failure(:internal_error)
            end

        end

        def result(context)
            note = context[:note]
            result = {note: note}
            Success(result)
        end

    end
end