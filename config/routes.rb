Rails.application.routes.draw do
  resources :customers, only: [:index, :new, :create]
  root to: "welcome#index"
end
