Rails.application.routes.draw do
  devise_for :users
  root "landing#show"
  resources :profiles do
    resources :sections, except: %i(index show) do
      resources :items, except: %i(index show)
    end
  end
end
