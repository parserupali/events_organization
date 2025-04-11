Rails.application.routes.draw do
 
  namespace :api do
    namespace :v1 do
      resources :events
      resources :customers
      resources :event_organizers

      devise_scope :user do
        post   'signin',  to: 'sessions#create'
        delete 'signout', to: 'sessions#destroy'
        post   'signup', to: 'registrations#create'

        post 'event_organizers/signup', to: 'event_organizers#signup'
        post 'customers/signup', to: 'customers#signup'
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
