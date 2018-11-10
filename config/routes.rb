Rails.application.routes.draw do

  get '/deeds/old', to: 'deeds#old'

  resources :deeds do
    resources :steps
  end
  get 'home/index'
  get '/', to: 'home#index'
  # get '/deeds/:id/history', to: 'deeds'

  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  post '/deeds/:id', to: 'deeds#change_state'

  delete '/deeds/:id/steps/:step_id', to: 'deeds#delete_state'
end
