Rails.application.routes.draw do
	root 'numbers#index'
	
  resources :numbers, only: [:index]
end
