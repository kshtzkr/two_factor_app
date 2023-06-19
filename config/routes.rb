Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'account_settings/edit', to: 'account_settings#edit', as: 'edit_account_settings'
  # get 'account_settings', to: 'account_settings#index', as: 'account_settings_index'
  patch 'account_settings', to: 'account_settings#update', as: 'update_account_settings'

  root 'account_settings#edit'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
