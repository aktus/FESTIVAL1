# coding: utf-8

FestivalDeIdeias::Application.routes.draw do

  # First role routes
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Authentication
  #root :to => "statics#home"
  
  #match "/tweet" => "users#tweet", :as => :tweet
  #match "/logout" => "sessions#destroy", :as => :logout
  #match "/connect_with_twitter" => "users#connect_with_twitter", :as => :connect_with_twitter
  #match '/auth/twitter/callback', :to => 'sessions#create',                :as => :session_create
  #match '/auth/twitter/callback' => 'sessions#auth_callback',                       :as => :auth_callback
  #match "/auth/failure" => "sessions#failure"
  #match "/logout" => "sessions#destroy", :as => :logout
  #match '/auth/:provider/callback' => 'sessions#auth_callback',               :as => :auth_callback
  post "/auth" => "sessions#auth", :as => :auth
  match "/auth/:provider/callback" => "sessions#create"
  #match '/auth/:provider/callback' => 'sessions#auth_callback',               :as => :auth_callback
  match '/auth/twitter/callback', :to => 'sessions#create',                :as => :session_create
  match '/signout' => 'sessions#destroy', :as => :signout,                   :as => :session_destroy
  match '/logout',                  :to => 'sessions#destroy',               :as => :session_destroy
  match '/connect_with_facebook',   :to => 'sessions#connect_with_facebook', :as => :connect_with_facebook
  match '/connect_with_twitter',   :to => 'sessions#connect_with_twitter', :as => :connect_with_twitter

  # Resources
  resources :users do
    member do
      put 'update_notification', :as => :update_notification
    end
  end
  resources :ideas do
    member do
      put "colaborate", :as => :colaborate
      get "accept_collaboration", :as => :accept_collaboration
      get "refuse_collaboration", :as => :refuse_collaboration
      get "collaboration", :as => :collaboration
    end
  end
  resources :non_facebook_users, :only => [:create]

###############Vote#################################################################################################################################
 resources :ideas do
    member do
      get "vote_up", :as => :vote_up
      get "vote_down", :as => :vote_down
    end
end
#####################################################################################################################################################
  # Scopes
  # NOTE: Mudado a pedidos da Natália
  scope '/navegue-nas-ideias' do
    get '/'        => redirect('/navegue-nas-ideias/popular'), :as => :scope_root

    #get 'popular'  => "ideas#index", :defaults => { :popular  => true }, :as => :scope_popular
    #get 'recent'   => "ideas#index", :defaults => { :recent   => true }, :as => :scope_recent
    #get 'latest'   => "ideas#index", :defaults => { :latest   => true }, :as => :scope_latest
    #get 'featured' => "ideas#index", :defaults => { :featured => true }, :as => :scope_featured

    get 'popular'  => "ideas#popular", :as => :scope_popular
    get 'recent'   => "ideas#recent", :as => :scope_recent
    get 'latest'   => "ideas#modified", :as => :scope_latest
    get 'featured' => "ideas#featured", :as => :scope_featured

    # Match relations ideas vs categories
    match ":idea_category_id/ideias", :to => "ideas#category", :as => :category_ideas
  end
  get '/ideias', :to => "ideas#index"
  scope '/ideias' do
    # Coisa da Natália... "É 'semântico!!'"
    match ":idea_category_id/ideia/:id", :to => "ideas#show",  :as => :category_idea
  end

  get "/miv" => "miv#index" if Rails.env.development?
  #root :to => redirect("/featured")
  root :to => 'ideas#index', :defaults => { :recent => true }


  resources :pages, :only => [] do
    collection { post :sort }
  end

  # Pages
  # Tem que ficar no final
  match '/:id', :to => 'pages#show', :as => :page
end
