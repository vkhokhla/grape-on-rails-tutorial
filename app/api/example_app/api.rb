class ExampleApp::API < Grape::API
  format :json
  prefix :api

  version 'v1', using: :path , vendor: 'skyrise' do
    before { Rails.logger.info "Request Body: #{request.body.read}" }

    get '/' do
      status 200
    end

    post '/login' do
      user = User.find_by_email(params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        user.generate_authentication_token!
        { user: user.login_json_info }
      else
        status 400
      end
    end
  end
end
