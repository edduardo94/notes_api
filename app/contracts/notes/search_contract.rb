module Notes
    class SearchContract < Dry::Validation::Contract

      params do
        optional(:page).value(:integer)
        optional(:per_page).value(:integer)
        optional(:title).value(:string)
        optional(:description).value(:string)
      end

      rule(:title) do
        key.failure('must not to be null ') if key? && value.nil?
      end

      rule(:description) do
        key.failure('must not to be null ') if key? && value.nil?
      end

      rule(:page) do
        key.failure('must higher than 0 ') if key? && (value < 1)
      end

      rule(:per_page) do
        if key?
          key.failure('must be higher than 0 ') if value < 1
          key.failure('must be lower than 31 ') if value > 30
        end
      end
    end
  end
