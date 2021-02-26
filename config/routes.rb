Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :notes do
        get :search
        get :list
      end
      post '/auth/login', to: 'auth#authenticate'
    end
  end
end
