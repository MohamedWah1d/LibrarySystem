Rails.application.routes.draw do
  resources :borrow_requests
  resources :shelves
  resources :book_categories
  resources :categories
  resources :books
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
    post 'auth/email_verification/send_email_otp', to: 'users/email_verification#send_email_otp'
    post 'auth/email_verification/verify_email_otp', to: 'users/email_verification#verify_email_otp'
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
