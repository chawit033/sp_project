Rails.application.routes.draw do
  devise_for :instructors, controllers: {
    sessions: 'instructors/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  get "/landing", to: "pages#landing"

  root "pages#index"
end
