Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }

  #sign_in,log_inせずともtop,about参照可能
  get '/' => "users/homes#top",as: 'home'
  get 'homes/about' => "users/homes#about",as: 'about'

  namespace :admins do
    get '/' => "admins/homes#top",as: 'home'
    get 'homes/about' => "admins/homes#about",as: 'about'
  end

  #namespace :users do
  #end
end
