Rails.application.routes.draw do
  resources :posts do
    member do
      put 'like', to: 'posts#like'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
