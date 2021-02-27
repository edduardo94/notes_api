module Notes
    class DeleteContract < Dry::Validation::Contract

        params do
            required(:id).value(:integer)
        end

        rule(:id) do
            key.failure("must to have a valid id") if value.nil? && value > 0
        end
    end
end