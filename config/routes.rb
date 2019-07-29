Rails.application.routes.draw do

  mount EpiCas::Engine, at: "/"

  resources :items do
    post :search, on: :collection
    get "loan", on: :collection
    get :show_image, on: :member
    post :makeloan, on: :collection
    post :loan, on: :collection
  end
  resources :categories do
    post :search, on: :collection
  end
  resources :colours do
    post :search, on: :collection
  end
  devise_for :users
  resources :users do
    post :search, on: :collection
    post :usertype, on: :collection
  end
  resources :catalogue
  resources :histories do
    post :search, on: :collection
    post :statistics, on: :collection
  end

  resources :subcategories
  resources :accessibility
  resources :contactus

  get '/loans/:id/extend', to:'loans#extend', as: 'extend_loan'
  resources :loans do
    post :search, on: :collection
    post :returnRequest, on: :collection
    post :returned, on: :collection
    post :cancel, on: :collection
    member do
      get 'View_User'
      post 'ReturnRequest'
      post 'Returned'
    end


  end
  resources :additem

  resources :uploads do
    post :upload_items, on: :collection
  end

  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  get 'filter_subcategories_by_category' => 'items#filter_subcategories_by_category'
  get 'myloans' => 'loans#myloans'
  get 'extend/:id' => 'loans#extend'

  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
