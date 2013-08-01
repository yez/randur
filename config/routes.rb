Randur::Application.routes.draw do
  root to: 'base#index'
  get 'new_url' => 'base#image_url'
end
