Rails.application.routes.draw do
  resources :messages

  get '/link' => 'messages#link'
  root 'messages#new'
end
