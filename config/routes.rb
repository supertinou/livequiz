Rails.application.routes.draw do
  resources :quizzes, constraints: { access_password: /^\d/ }
  root to: "quizzes#new" 
end
