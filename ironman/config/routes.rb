Rails.application.routes.draw do
  devise_for :users
  resources :keyword_mappings
  get '/kamigo/eat', to: 'kamigo#eat'
  get '/kamigo/request_headers', to: 'kamigo#request_headers'
  get '/kamigo/request_body', to: 'kamigo#request_body'
  get '/kamigo/response_headers', to: 'kamigo#response_headers'
  get '/kamigo/response_body', to: 'kamigo#show_response_body'
  post '/kamigo/webhook', to: 'kamigo#webhook'
  get '/kamigo/sent_request', to: 'kamigo#sent_request'

  resources :push_messages, only: [:new, :create]
end
