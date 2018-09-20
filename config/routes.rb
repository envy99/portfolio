Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "landing#show"
  resources :profiles do
    resources :sections, except: %i(index show) do
      resources :items, except: %i(index show)
    end
  end
  namespace :oauth do
    resources :user
    resources :merge_user
    get "linkedin/fetch_authorization_code", to: "linkedin#fetch_authorization_code"
    get "linkedin/fetch_user_data", to: "linkedin#fetch_user_data"
  end
end
