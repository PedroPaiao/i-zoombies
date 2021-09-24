Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :survivors do
        put :location, on: :member, controller: :locations, action: :update
        get :retrieve_closest_survivor, on: :member, controller: :locations, action: :retrieve_closest_survivor

        post :create, on: :member, controller: :reports, action: :create
      end
    end
  end
end
