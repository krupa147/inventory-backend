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
    resources :inventories
    resources :users
    post :reset_password, to: "passwords#reset"
    get :forgot_password, to: "passwords#forgot"
  end
end
