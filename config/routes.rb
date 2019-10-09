Rails.application.routes.draw do
  root 'welcome#index'
  get 'users/index'
  get 'users/show'
  get 'login', to: "login#index"
  get 'welcome/index'
  get 'new', to: "postings#new"
  resources :users, path: '/', param: :username do
    resources :shelves
    resources :postings
  end
  resolve("Posting") do |posting|
    [posting.user, posting]
  end
  resolve("Shelf") do |shelf|
    [shelf.user, shelf]
  end
  post "shelf/create", to: "users#create_shelf", as: "create_shelf"
  get "post/:id", to: "postings#show"
  get "posts", to: "postings#index"
  post "users/upload-csv", to: "users#upload_csv"

  
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
