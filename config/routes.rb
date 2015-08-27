Rails.application.routes.draw do


  get 'chats/new'

  get 'chats/create'

  get 'chats/update'

  get 'chats/destroy'

  get 'chats/show'

  # get 'users/:id' => 'users#show'
  get 'pages/:id' => 'pages#index'
  resources :products

  get 'products/:id' => 'products#show'
  # root :to => 'products#index'

  # ======= THESE GO TOGETHER =======
  devise_for :users, :controllers => { :omniauth_callbacks => "sessions",
    registrations: 'registrations' }
  resources :users, only: [:show, :edit]

  post 'users/:id/follow' => 'users#follow', as: :follow_user
  delete 'users/:id/follow' => 'users#unfollow'
  # =================================

  # :id is current user's id
  get '/mains/:id/posts' => 'mains#posts'
  resources :mains




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'products#index'



  # mailbox
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  # conversations
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
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
