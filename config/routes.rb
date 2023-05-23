Rails.application.routes.draw do
  resources :customers, only: [:index, :new]
  root to: "welcome#index"
end
