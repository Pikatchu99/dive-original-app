Rails.application.routes.draw do
  resources :structures
  root "homepage#homepage"
  # devise_for :users

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
