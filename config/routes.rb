Rails.application.routes.draw do
  root to: "boards#index"
  resources :boards do
    resources :tasks, only: %i(new create show edit update destroy) do
      resources :comments, only: %i(new create)
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
