Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/parse/', to: 'parse#parse'
  post '/find/', to: 'parse#find'
end
