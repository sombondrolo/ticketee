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

    resources :states, only: [:index, :new, :create] do
      member do
        patch :make_default
      end
    end
  end

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      collection do
        post :upload_file
      end

      member do
        patch :watch
      end
    end
  end

  scope path: "tickets/:ticket_id", as: :ticket do
    resources :comments, only: [:create]
  end
end
