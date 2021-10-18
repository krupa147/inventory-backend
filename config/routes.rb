Rails.application.routes.draw do
  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: 'api/login',             },
             controllers: {
               sessions: 'sessions',
             }

  scope :api do
    resources :inventories do
      patch :update_status, on: :member
    end
    resources :users
    post :reset_password, to: "passwords#reset"
    get :forgot_password, to: "passwords#forgot"
  end
end
