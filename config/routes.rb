Rails.application.routes.draw do

  devise_for :employees, controllers: { registrations: "registrations"}
  get 'welcome/index'
  resources :admins
  resources :schedules


  authenticated :employee do
    root 'schedules#index', as: "authenticated_root"
  end

  root 'welcome#index'

end
