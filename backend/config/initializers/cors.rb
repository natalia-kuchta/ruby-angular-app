
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Replace '*' with specific origins as needed, e.g., 'https://example.com'

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             expose: ['Authorization'] # Specify headers to expose if needed
  end
end