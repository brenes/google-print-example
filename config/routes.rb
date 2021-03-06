Rails.application.routes.draw do
  resources :printers, only: [:index, :show] do
    resources :print_jobs, only: [:create, :show]
  end

  root to: 'setup#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
