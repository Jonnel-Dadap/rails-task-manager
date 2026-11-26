Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  get "/tasks", to: "tasks#index", as: :tasks
  get "/tasks/archive", to: "tasks#archive", as: :archive_tasks
  get "/tasks/new", to: "tasks#new", as: :new_task
  post "/tasks", to: "tasks#create"

  get "/tasks/:id", to: "tasks#show", as: :task
  get "/tasks/:id/edit", to: "tasks#edit", as: :edit_task

  patch "/tasks/:id", to: "tasks#update"
  put "/tasks/:id", to: "tasks#update"
  delete "/tasks/:id", to: "tasks#destroy"

  patch "/tasks/:id/archive", to: "tasks#archive_task", as: :archive_task
  patch "/tasks/:id/restore", to: "tasks#restore", as: :restore_task

  get "up" => "rails/health#show", as: :rails_health_check
end
