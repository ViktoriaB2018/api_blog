Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[create] do
        put :rate, on: :member
      end
    end
  end
end
