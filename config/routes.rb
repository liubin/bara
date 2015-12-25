Rails.application.routes.draw do

  get 'images' => 'images#index'
  get 'images/add'
  post 'images/pull'
  delete 'images/:id' => 'images#delete', as: 'delete_image'
  get 'images/:id' => 'images#show', as: 'image'

  resources :templates do
    member do
      post 'active'
    end
  end

  resources :containers do
    member do
      post 'start'
      post 'stop'
      get 'logs'
    end
  end

  get 'dash/index'

  get 'nginx' => 'nginx#show'
  get 'nginx/edit'
  get 'nginx/edit_template'
  post 'nginx/reload'
  post 'nginx/update'
  post 'nginx/generate'


  get 'profile' => 'profile#show'
  get 'profile/edit'
  post 'profile/update'

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: "containers#index"
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
