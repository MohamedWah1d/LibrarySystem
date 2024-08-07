Rails.application.routes.draw do
  namespace :v1 do
    resources :books do
      resources :reviews, only: [:index, :create]
    end
    resources :borrow_requests do
      member do
        post :return
      end
    end
    resources :shelves
    resources :categories
    resources :reviews, only: [:show, :update, :destroy]
  end
  devise_for :users, path: '', path_names: {
    sign_in: 'auth/login',
    sign_out: 'auth/logout',
    registration: 'auth/signup',
    password: 'auth/password'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'user/passwords'
  }

  devise_scope :user do
    post 'auth/passwords/request_password_reset', to: 'users/passwords#create'
    post 'auth/passwords/validate_otp', to: 'users/passwords#validate_otp'
    put 'auth/passwords/reset_password', to: 'users/passwords#update'
    put 'auth/passwords/change_password', to: 'users/passwords#update_password'
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
