require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  namespace :api do
    namespace :v1 do
      resources :posts do
        resources :comments, only: %i[index create]
      end
      resources :comments, only: %i[show update destroy]
      resources :categories, only: %i[index show]
      resources :tags, only: %i[index show]
    end
  end

  post "/graphql", to: "graphql#execute"
  get "/graphql", to: "graphql#execute"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
end
