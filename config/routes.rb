Rails.application.routes.draw do
  get 'pages/index'
  root to: 'pages#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'sign-in',
    sign_out: 'sign-out',
    sign_up: 'sign-up',
    password: 'password',
    confirmation: 'verification'
  }
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :comments, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

  namespace :api do
    namespace :v1 do
      post 'login', to: 'login#index'
      resources :users, only: [] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
      end
    end
    end
  end
end
