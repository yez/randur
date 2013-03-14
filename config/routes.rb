Randur::Application.routes.draw do
  root to: 'base#index'
  match 'new_url' => 'base#image_url'
end
