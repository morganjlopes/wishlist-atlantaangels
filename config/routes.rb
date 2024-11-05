Rails.application.routes.draw do

  mount LetterOpenerWeb::Engine, at: "/letter_opener" unless Rails.env.production?

  devise_for :users, controllers: {
    registrations:      'users/registrations',
    sessions:           'users/sessions',
    unlocks:            'users/unlocks',
    passwords:          'users/passwords'
  }

  resources :events do
    resources :lists, only: [:index, :show] do
      collection do
        get :feed
      end

      member do
        get :claim
      end
    end
    
    resources :families do
      member do
        put :lists_complete
        get :confirmation
      end

      resources :lists
    end

  end

  resources :sponsors

  namespace :admin do
    resource :settings
    resources :sponsors
    resources :users, only: [:index]
    resources :ahoy_visits, only: [:index], path: 'visits'
    resources :ahoy_events, only: [:index], path: 'ahoy_events'
    resources :events
    resources :lists
    resources :families
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "events#index"
end
