Rails.application.routes.draw do

  resources :participants
  resources :participants
  resources :quizzes, constraints: { access_password: /^\d/ } do
  	resources :sessions, only: [:new, :create,:show, :edit]
  end

  resources :sessions, only: [:show, :edit, :update, :destroy] 

  root to: "quizzes#new" 
end
