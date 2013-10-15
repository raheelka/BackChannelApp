Auth::Application.routes.draw do



  get "all_post" => "posts#index", :as => "all_post"
  get "votedup" => "posts#votedup", :as => "votedup"
  get "votedCommentUp" => "posts#votedCommentUp", :as => "votedCommentUp"
  post "saveComment" => "posts#saveComment", :as => "saveComment"

  post "comments/update" => "comments#update", :as => "update"

  get "viewReportAj" => "users#viewReportAj", :as => "viewReportAj"
  get "new_post" => "posts#new", :as => "new_post"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "all_users" => "users#alluserdata", :as => "all_users"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "users/createAdmin"

  post "posts/editComment"

  post "users/saveAdmin"
  post "users/promoteToAdmin"
  post "users/revokeAdmin"
  post "posts/search"
  get "users/viewReport"
  post "users/viewReport"
  post "posts/deleteComment"

  resources :posts do
    get 'searchAuto', :on => :collection
  end

  root :to => "users#new"
  resources :users
  resources :sessions
  resources :posts
  resources :category_reps
  resources :comments
end
