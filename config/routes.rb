Rails.application.routes.draw do

  devise_for :employees, controllers: { registrations: "registrations"}
  get 'welcome/index'
  resources :admins
  resources :schedules

  get 'admins/:id/report' => "admins#report"
  get 'admins/:id/doReport' => "admins#doReport"
  get 'admins/:id/doReportDays' => "admins#doReportDays"

  authenticated :employee do
    root 'schedules#index', as: "authenticated_root"
  end

  root 'welcome#index'

end
