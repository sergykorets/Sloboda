Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :authors, :controllers => { registrations: 'registrations' }
  root to: 'blog/books#index'

  namespace :authors do
    resources :tags, only: [:new, :create, :edit, :update, :destroy]
  	resources :books do
      member do 
        put 'publish' => 'books#publish'
        put 'unpublish' => 'books#unpublish'
      end
    end
  end

  namespace :blog do
    resources :tags, only: [:index, :show]
    resources :books, only: [:show, :index]
  end

  # scope module: 'blog' do
  # 	get 'books' => 'books#index', as: :books
  # 	get 'books/:id' => 'books#show', as: :post
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
