require "jwt"
require "httparty"
require "json"

class HomeController < ApplicationController
  def index
    @user = current_user
    payload = { user: current_user.email }
    @token = JWT.encode payload, nil, 'none'

    forms_response = HTTParty.get(
      "#{ENV['FORMS_API_URL']}published",
      headers: {
        "X_API_KEY" => @token
      }
    )

    @forms = JSON.parse(forms_response.body)
  end
end
