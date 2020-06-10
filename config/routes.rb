Rails.application.routes.draw do
  resources :categories
  resources :entries
  resources :prints, only: [:index] do
    collection do
      get :trigger
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'entries#index'
end
