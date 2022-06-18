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

    resources :states, only: [:index, :new, :create]
  end

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets
  end

  scope path: "tickets/:ticket_id", as: :ticket do
    resources :comments, only: [:create]
  end
end
