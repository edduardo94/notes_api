module Auth
    class AuthContract < Dry::Validation::Contract
        EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

        params do
            required(:email).value(:string)
            required(:password).value(:string)
        end

        rule(:email) do
            key.failure("must be a valid email") if !EMAIL_REGEX.match(value)
        end
    end
end