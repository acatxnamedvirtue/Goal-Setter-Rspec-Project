Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :index] do
    resources :goals, only: [:new, :edit]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:new, :edit, :index] do
  end
  resources :comments, only: [:destroy, :create]

  root to: "users#index"
end
