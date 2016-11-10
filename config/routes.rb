Rails.application.routes.draw do
  devise_for :users
  resources :lists do
  	resources :items do
  	  member do
  	    patch :complete
  	  end
    end
  end

  root "lists#index"
end
