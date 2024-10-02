Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" unless Rails.env.production?

  devise_for :users, controllers: {
    registrations:      'users/registrations',
    sessions:           'users/sessions',
    unlocks:            'users/unlocks',
    passwords:          'users/passwords'
  }

  namespace :admin do
    resource :settings
    resources :users, only: [:index]
    resources :ahoy_visits, only: [:index], path: 'visits'
    resources :ahoy_events, only: [:index], path: 'events'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "admin/users#index"
end
