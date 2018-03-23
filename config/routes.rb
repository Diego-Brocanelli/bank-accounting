Rails.application.routes.draw do
  resources :accounts
  post '/accounts/deposit/:source_account_id/:destination_account_id', controller: 'accounts', action: 'deposit', as: 'deposit'
  get '/accounts/balance/:account_id', controller: 'accounts', action: 'balance', as: 'balance'
end
