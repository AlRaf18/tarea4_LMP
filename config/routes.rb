Rails.application.routes.draw do
  root 'tasks#index'

  get 'set_filter_cookie', to: 'tasks#set_filter_cookie'
  get 'delete_filter_cookie', to: 'tasks#delete_filter_cookie'
  post 'complete_task/:id', to: 'tasks#complete_task', as: "complete_task"
  
  get 'init_session', to: 'sessions#init_session'
  get 'session_to_cookie', to: 'sessions#save_session'  
  get 'log_out', to: 'sessions#delete_session_cookie'

  resources :tasks

end
