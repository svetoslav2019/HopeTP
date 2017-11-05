Rails.application.routes.draw do
  
  get 'text' => 'hw#index'
  post 'text' => 'hw#fonction'
  get 'print' => 'hw#print'
  post 'print' => 'hw#print'
  get 'see' => 'hw#see'
  post 'see' => 'hw#see'
post '/messages/api', to: 'notes#create'
end
