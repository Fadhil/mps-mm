Mps::Application.routes.draw do


  localized do
    devise_for :users, controllers: { sessions: 'mydevise/sessions' }
    get '/welcome' => 'application#welcome'
    get 'city_dropdown' => 'application#city_dropdown', as: :city_dropdown
    match '/open_email' => 'events#open_email'
    resources :events do
      collection do
        post 'filter' => 'events#filter', as: :filter
      end
      member do
        post '' => 'events#show'
        post 'send_invites' => 'events#send_invites', as: :send_invites_to
        post 'update_attendance' => 'events#update_attendance'
        post 'add_walkins' => 'events#add_walkins'
        get 'coming' => 'events#coming'
        match 'edit_recipients' => 'events#edit_recipients'
        get 'terima_kasih' => 'events#terima_kasih'
        get 'already_responded' => 'events#already_responded'
        get 'track_open/:attendee_id' => 'events#track_open', as: :track_open
        get '/:attendee_id/invitation' => 'events#show_invitation', as: :show_invitation
        get '/:attendee_id/:rsvp_response' => 'events#update_rsvp', as: :update_rsvp
      end
    end

    resources :media_profiles do
      collection do 
        match 'filter' => 'media_profiles#filter', as: :filter
      end
    end

    root to: 'application#welcome', as: :welcome
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
