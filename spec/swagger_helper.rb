require 'rails_helper'

RSpec.configure do |config|
  # Define where Swagger JSON/YAML files will be generated
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {}
    }
  }

  # Specify the format of Swagger files (JSON or YAML)
  config.swagger_format = :yaml
end
