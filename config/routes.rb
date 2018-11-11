Rails.application.routes.draw do
  get '/', to: 'health_check#index'
  post '/file', to: 'files#create'
end
