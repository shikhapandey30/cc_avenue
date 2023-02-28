Rails.application.routes.draw do
  resources :homes
  root "homes#index"
  resources :transactions do 
    collection do
      post :response_handler
    end
  end
  post "/transaction/ccavRequestHandler", to: "transactions#create"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
