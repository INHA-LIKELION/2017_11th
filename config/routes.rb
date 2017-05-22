Rails.application.routes.draw do
  get 'home/index'

  get 'home/sendMail'

  root 'home#index'

  get 'home/crawler'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
