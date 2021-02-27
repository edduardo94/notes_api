module Notes
    class UpdateContract < Dry::Validation::Contract        

        params do
            required(:id).value(:integer)
            required(:title).value(:string)
            required(:description).value(:string)
        end

        rule(:id) do 
            key.failure("must to have a valid id") if value.nil? && value > 0
        end

        rule(:title) do            
            key.failure("title must not to be null") if value.nil?
        end

        rule(:description) do
            key.failure("description must not to be null") if value.nil?
        end
    end
end