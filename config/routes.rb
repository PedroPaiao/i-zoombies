Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :survivors do
        put :location, on: :member, controller: :locations, action: :update
      end
    end
  end
end
