Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :albums do
        post '/:album_id/photobooks', to: 'photobooks#create'
        post '/:album_id/dvds', to: 'dvds#create'
      end
      namespace :accounts do
        post '/:account_id/orders', to: 'orders#create'
      end
    end
  end
end
