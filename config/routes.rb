SampleApp::Application.routes.draw do
 
  
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_up => 'signup'},
   :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  resources :users do
    get :admin, :on => :member
    get :post, :on => :member
    post :avatar, :on => :member
   

  end  
  #resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :properties do
     get :facebook_share, :on => :member
  end  

  #do
  #  get :add_collection, :on => :member
  #  get :del_collection, :on => :member
  #  get :collect, :on => :member

  #end

  resources :collections  do
    get :add, :on => :member 
    get :del, :on => :member
    get :collect, :on => :member 
  end 
  
  resources :photos 
  resources :reset_password, only: [:new, :create] 
  resources :searches do
    get :search, :on => :member
  end

  resources :contact_forms


  root :to => 'static_pages#home'
  
  get "static_pages/help"
  #get '/test', :to => redirect('/test.html')
 
  #match '/post', to: 'static_pages#post', via: 'get'
  
  match '/about', to: 'static_pages#about', via: 'get'
  match '/home', to: 'static_pages#home', via: 'get'
  #match '/signup', to: 'users#new', via: 'get'
  #match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  

  #match '/photos', to: 'photos/#create', via: 'post'
  #get '/test', to: 'photos/#show'

  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
