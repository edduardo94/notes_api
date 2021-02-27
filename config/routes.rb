Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :notes do
        get :search
        get :list
        post :create
        get :free_notes
      end
      delete 'notes/:id' , to: 'notes#destroy'
      put 'notes/:id' , to: 'notes#update'
      get 'notes/:id' , to: 'notes#show'
      post '/auth/login', to: 'auth#authenticate'
    end
  end
end
