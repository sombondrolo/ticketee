Rails.application.routes.draw do
  root "projects#index"

  devise_for :users
  namespace :admin do
    root "application#index"

    resources :projects, except: [:index, :show]

    resources :users do
      member do
        patch :archive
      end
    end
  end

  resources :projects, only: [:index, :show] do
    resources :tickets
  end
end
