module Notes
    class UpdateOperation < Operation
        include Dry::Transaction

        step :validate_contract
        step :execute_query
        step :result

        def execute_query(context)
            contract = context[:contract]
            current_user = context[:current_user]
            note = current_user.notes.find_by(id: context[:contract][:id])
            if note.nil?
                Failure(:not_found)
            else
                note.update(title: contract[:title], description: contract[:description])
                context[:note] = note
                Success(context)
            end
        end

        def result(context)
            note = context[:note]
            result = {note: note}
            Success(result)
        end

    end
end