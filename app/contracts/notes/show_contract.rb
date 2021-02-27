module Notes
    class ShowContract < Dry::Validation::Contract

      params do
        required(:id).value(:integer)
      end

      rule(:id) do
        key.failure('must higher than 0 ') if value.nil? && value > 0
      end
    end
  end
