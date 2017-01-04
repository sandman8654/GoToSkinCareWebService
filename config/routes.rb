Rails.application.routes.draw do
  get 'user/new'
  get 'user/login'
  get 'user/register'
  get 'use/verifyAddress'
  get 'user/updateProfile'
  get 'user/resetPassword'
  get 'product/list'
  get 'order/calculate'
  get 'order/place'
  get 'order/list'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
