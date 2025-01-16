Rails.application.routes.draw do
  mount Rswag::Api::Engine => "/api-docs"
  mount Rswag::Ui::Engine => "/api-docs"
  namespace :api do
    namespace :v1 do
      resources :email_trackings, param: :uuid, only: [ :create ] do
        collection do
          get :stats
        end
        resources :download_hits, only: [] do
          collection do
            get "track", to: "download_hits#track"
          end
        end
      end
    end
  end
end
