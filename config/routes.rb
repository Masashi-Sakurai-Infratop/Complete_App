Rails.application.routes.draw do
  get 'lists/new'
  get 'lists' => 'lists#index'
  get 'lists/:id/edit' => 'lists#edit', as: 'edit_list'
  get 'top' => 'homes#top'
  post 'lists' => 'lists#create'
  # .../lists/1や .../lists/3に該当する
  get 'lists/:id' => 'lists#show', as:'list'
  patch 'lists/:id' => 'lists#update', as: 'update_list'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
