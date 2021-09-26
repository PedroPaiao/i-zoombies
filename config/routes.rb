Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :survivors do
        put :move_all_survivors, on: :collection, action: :move_all_survivors

        put :location, on: :member, controller: :locations, action: :update
        get :retrieve_closest_survivor, on: :member, controller: :locations, action: :retrieve_closest_survivor

        post :reports, on: :member, controller: :reports, action: :create
        get :complaints_about_me, on: :member, controller: :reports, action: :complaints_about_me
        get :my_complaints, on: :member, controller: :reports, action: :my_complaints
      end
    end
  end
end