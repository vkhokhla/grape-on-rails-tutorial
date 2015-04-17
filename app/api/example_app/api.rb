class ExampleApp::API < Grape::API
  format :json
  prefix :api

  version 'v1', using: :path , vendor: 'skyrise' do
    before { Rails.logger.info "Request Body: #{request.body.read}" }

    get '/' do
      status 200
    end
  end
end
