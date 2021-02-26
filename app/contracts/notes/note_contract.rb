module Repos
    class SearchContract < Dry::Validation::Contract
      ORDER = %w[asc desc].freeze
      SORT = %w[updated forks stars].freeze
  
      params do
        optional(:page).value(:integer)
        optional(:per_page).value(:integer)
        optional(:sort).value(:string)
        optional(:order).value(:string)        
        optional(:text).value(:string)
      end
  
      rule(:order, :sort) do
        key.failure('only order sorted values') if values[:order].present? && !values[:sort].present?
      end
  
      rule(:sort) do
        if key? && !(SORT.include? value)
          key.failure(
            'must to be stars,forks or update date'
          )
        end
      end
  
      rule(:order) do
        if key? && !(ORDER.include? value)
          key.failure(
            'must to be desc or asc '
          )
        end
      end        
  
      rule(:text) do
        key.failure('text must not be to blank') if key? && value.blank?
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
  