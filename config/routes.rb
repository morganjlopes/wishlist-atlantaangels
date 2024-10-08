Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" unless Rails.env.production?

  devise_for :users, controllers: {
    registrations:      'users/registrations',
    sessions:           'users/sessions',
    unlocks:            'users/unlocks',
    passwords:          'users/passwords'
  }

  resources :events do
    resources :families do
      member do
        put :lists_complete
        get :confirmation
      end

      resources :lists
    end
  end

  namespace :admin do
    resource :settings
    resources :users, only: [:index]
    resources :ahoy_visits, only: [:index], path: 'visits'
    resources :ahoy_events, only: [:index], path: 'ahoy_events'
    resources :events
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "admin/users#index"
end
