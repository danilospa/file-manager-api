Rails.application.routes.draw do
  get '/', to: 'health_check#index'
  post '/file', to: 'files#create'
  get '/files/:tag_search_query/:page', to: 'files#search'
end
