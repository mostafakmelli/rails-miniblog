if defined?(GraphiQL::Rails)
  GraphiQL::Rails.config.initial_query = <<-GRAPHQL

    {
      posts {
        id
        title
      }
    }
  GRAPHQL
end
