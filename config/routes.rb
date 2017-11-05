Rails.application.routes.draw do
  resources :notes
  get '/notes/:id/info', to: 'notes#info'
  post '/messages/api', to: 'notes#create'
end