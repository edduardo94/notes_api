module Notes
    class CreateContract < Dry::Validation::Contract

        params do
            required(:title).value(:string)
            required(:description).value(:string)
        end

        rule(:title) do
            key.failure("title must not to be null") if value.nil?
        end

        rule(:description) do
            key.failure("description must not to be null") if value.nil?
        end
    end
end