Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'auth/login',
    sign_out: 'auth/logout',
    registration: 'auth/signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get "up" => "rails/health#show", as: :rails_health_check

end
