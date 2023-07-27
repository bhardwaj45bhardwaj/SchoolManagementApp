Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
   # mount Rswag::Ui::Engine => '/api-docs'
  # mount Rswag::Api::Engine => '/api-docs'
  root :to => redirect("/users/login")
  resources :roles
  #devise_for :users

  scope '/admin' do
    resources :users, only: [:index, :create, :update] do 
      get :batch_students, on: :member
    end
  end

  resources :schools, only: [:index, :create, :update]
  resources :courses, only: [:index, :create, :update]
  resources :batches, only: [:index, :create, :update]
  resources :enrollments, only: [:index, :create, :update, :destroy]



   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
