Pictures::Application.routes.draw do |map|
=begin
  resources :items do
    member do
      get :more_info
    end
    collection do
      get :import_and_update
      get :bulk_export
      get :info
      get :quit
    end    
  end

  resources :books, :only => [:show]
  resources :videos, :only => [:show]

  root :to => "items#index"
=end
  
  match '/files(/*path)' => 'files#show'

  root :to => "files#show"

  match '/stylesheets/dynamic.css' => 'items#dynamic_stylesheet'
end
