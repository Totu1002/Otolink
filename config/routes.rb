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
  get "/" => "users/homes#top",as: "home"
  get "homes/about" => "users/homes#about",as: "about"

  scope module: "users" do
    resources :users, only:[:show, :edit, :update]
    #ユーザー論理退会アクション
    get "user/withdrawl"=> "users#withdrawl"
    patch "user/withdrawl" => "users#hide"
    resources :recruits, only:[:new, :create, :show, :edit, :update, :destroy]
    #記事投稿ページ
    get "user/recruit_member"=> "recruits#recruit_member"
    get "user/recruit_band"=> "recruits#recruit_band"
    #検索機能
    get "search_recruit" => "recruits#search_recruit"
    get "search_member" => "userss#search_member"
  end

  namespace :admins do
    get "/" => "admins/homes#top",as: 'home'
    get "homes/about" => "admins/homes#about",as: "about"
    resources :users, only:[:show, :edit, :update]
    resources :recruits, only:[:show, :edit, :update, :destroy]
  end

end
