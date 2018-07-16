Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "landing#show"
  resources :profiles do
    resources :sections, except: %i(index show) do
      resources :items, except: %i(index show)
    end
  end
end
