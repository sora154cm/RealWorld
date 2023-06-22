Rails.application.routes.draw do
  #ルーティングをapiから始まるようにする
  namespace :api do
    #paramをidからslugに変更
    resources :articles, param: :slug, only: [:create, :show, :update, :destroy]
  end
end
