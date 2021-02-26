module Repos
    class SearchContract < Dry::Validation::Contract      
  
      params do
        optional(:page).value(:integer)
        optional(:per_page).value(:integer)                
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
  