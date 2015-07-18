Rails.application.routes.draw do
  resources :quizzes
  root to: "quizzes#new" 
end
