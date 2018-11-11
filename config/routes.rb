Rails.application.routes.draw do
  get '/', to: 'health_check#index'
end
