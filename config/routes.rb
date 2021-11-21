Rails.application.routes.draw do
  #customer
  root to: "customers/homes#top"
  get 'about' => 'customers/homes#about'
  get '/customers/contact' => 'customers/customers#contact'

  devise_for :customers, :controllers => {:sessions => 'customers/sessions',
    :registrations => 'customers/registrations',
    :passwords => 'customers/passwords'
  }
  scope module: :customers do
    resources :items,only:[:index, :show]
    get 'edit/customers' => 'customers#edit'
    patch 'update/customers' => 'customers#update'
    resource :customers,only:[:edit, :update, :show] do
      collection do
        get 'quit'
        patch 'out'
      end
    end

    resources :cart_items, only:[:index, :update, :create, :destroy] do
      collection do
        delete '/' => 'cart_items#all_destroy'
      end
    end
    resources :orders, only:[:new, :index, :show, :create] do
      collection do
        post 'confirm'
        get 'thanx'
      end
    end
    resources :addresses, only:[:index, :create, :edit, :update, :destroy]
  end

  #admin
  devise_for :admins, :controllers => {
    :sessions => 'admin/sessions',
    :registrations => 'admin/registrations',
  }

  get "/admin" => "admin/homes#index"

  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update]
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :genres, only:[:index, :new, :create, :show, :edit, :update]
    resources :orders, only:[:index, :show, :update] do
      member do
        get :current_index
        resource :order_details, only:[:update]
      end
      collection do
        get :today_order_index
      end
    end
  end
end
