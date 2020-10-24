Rails.application.routes.draw do

  namespace :users do
    get "rooms/index"
    get "rooms/show"
  end

  devise_for :admins, controllers: {
    registrations: "admins/registrations",
    passwords: "admins/passwords",
    sessions: "admins/sessions"
  }

  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords",
    sessions: "users/sessions"
  }

  #sign_in,log_inせずともtop,about参照可能
  get "/" => "users/homes#top",as: "home"
  get "homes/about" => "users/homes#about",as: "about"

  #ゲストサインイン機能
  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#new_guest'
  end

  scope module: "users" do
    resources :users, only:[:index, :show, :edit, :update]
    #ユーザー論理退会アクション
    get "user/withdrawl" => "users#withdrawl"
    patch "user/withdrawl" => "users#hide"
    #投稿記事ルーティング
    resources :recruits, only:[:new, :create,:index, :show, :edit, :update, :destroy]
    #DM機能ルーティング
    resources :messages, only: [:create, :destroy]
    resources :rooms, only: [:create, :index, :show]
    #新規記事投稿ページルーティング
    get "user/recruit_member"=> "recruits#recruit_member"
    get "user/recruit_band"=> "recruits#recruit_band"
    #検索機能ルーティング
    get "recruit/search" => "recruits#search"
    get "user/search" => "users#search"
  end

  namespace :admins do
    get "/" => "admins/homes#top",as: 'home'
    get "homes/about" => "admins/homes#about",as: "about"
    resources :users, only:[:index, :show, :edit, :update]
    resources :recruits, only:[:index, :show, :edit, :update, :destroy]
  end

end
