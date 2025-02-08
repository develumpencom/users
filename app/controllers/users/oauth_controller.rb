module Users
  class OauthController < ApplicationController
    allow_unauthenticated_access

    def auth
      redirect_to auth_uri, allow_other_host: true
    end

    def callback
      data = exchange_code_for_token
      user_data = decode_token(data[:id_token])

      # TODO: handle possible errors (duplicate id, email).
      user = User.find_or_create_by!(breakable_toys_id: user_data["sub"]) do |u|
        u.email_address = user_data["email"]
        u.password = SecureRandom.hex(16)
      end

      start_new_session_for(user)
      redirect_to main_app.root_path

    rescue JWT::VerificationError => error
      # TODO: handle the error.
      puts "-" * 100
      p error
      puts "-" * 100
    end

    private

    def auth_uri
      # TODO: add state to prevent CSRF.
      url_params = {
        response_type: "code",
        client_id: Users.configuration.breakable_toys_client_id,
        redirect_uri: oauth_callback_url,
        state: "fake-state"
      }
      uri = URI(Users.configuration.oauth_server_url + "/oauth/auth")
      uri.query = URI.encode_www_form(url_params)

      uri
    end

    def token_uri
      url_params = {
        grant_type: "authorization_code",
        code: params[:code],
        redirect_uri: oauth_callback_url,
        client_id: Users.configuration.breakable_toys_client_id,
        client_secret: Users.configuration.breakable_toys_client_secret
      }
      uri = URI(Users.configuration.oauth_server_url + "/oauth/token")
      uri.query = URI.encode_www_form(url_params)

      uri
    end

    def exchange_code_for_token
      response = Faraday.post(token_uri)

      JSON.parse(response.body, symbolize_names: true)
    end

    def decode_token(id_token)
      JWT.decode(id_token, Users.configuration.breakable_toys_client_id, true, { algorithm: "HS256" })[0]
    end
  end
end
