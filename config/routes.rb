Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'login', to: "login#index"
  get 'welcome/index'
  resources :books
  resources :users, path: 'u', param: :username do
    resources :shelves
    resources :postings
  end
  post "shelf/create", to: "users#create_shelf", as: "create_shelf"
  get ":username/shelf/:shelfname", to: "users#show_shelf", as: "shelf"
  get "post/:id", to: "postings#show"
  get "posts", to: "postings#index"
  post "users/upload-csv", to: "users#upload_csv"

  root 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
