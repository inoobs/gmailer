Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  get '/enable', to: 'gmailer#enable'
  post '/get_data', to: 'gmailer#fetch_mails'
end
