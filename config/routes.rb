Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/"         => "home#top"
  get "about"     => "home#about"
  get "guideline" => "home#guideline"
  get "userpage"  => "home#userpage"
  get "links"     => "home#links"
  get "login"     => "home#login"
end
