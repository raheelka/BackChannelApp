Auth::Application.routes.draw do



  get "all_post" => "posts#index", :as => "all_post"
  get "new_post" => "posts#new", :as => "new_post"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "all_users" => "users#alluserdata", :as => "all_users"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "users/createAdmin"
  post "users/saveAdmin"
  post "posts/search"
  root :to => "users#new"
  resources :users
  resources :sessions
  resources :posts
  resources :category_reps
end
