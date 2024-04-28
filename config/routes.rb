# frozen_string_literal: true

# rubocop:disable all

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

    resources :data_center, only: [:index, :edit, :show, :export], path: 'data-center' do
      collection do
        get :export
        post :import
        post :import_from_files
      end
    end



    resources :users, only: [:index, :edit, :show, :export] do
      collection do
        get :export
        post :import
      end
    end

    resources :sync_dms, only: [:index, :edit, :show, :export], path: 'dms' do
      collection do
        get :export
        post :import
        post :import_from_files
      end
    end
  
    resources :sync_seasofts, only: [:index, :edit, :show, :export], path: 'seasoft' do
      collection do
        get :export
        post :import
        post :import_from_files
      end
    end

    resources :sync_files, only: [:index, :edit, :show, :export], path: 'files' do
      collection do
        get :export
        post :import
      end
    end

  get '/logout', to: 'sessions#destroy'

  # Defines the root path route ("/")
  # root "posts#index"
  root to: 'overview#index'

end
