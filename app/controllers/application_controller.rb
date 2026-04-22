class ApplicationController < ActionController::API
  wrap_parameters false

  class AuthenticationError < StandardError; end

  rescue_from AuthenticationError, with: :render_unauthorized

  private
    # https://jwt.io/
    def authentication
      token = request.headers["Authorization"].to_s.split.last
      raise AuthenticationError if token.blank?

      JWT.decode token, "9C29AA3B6A47A440B20067DFF29F556EF22AD88A5D8F5E01F6B1A6962397C45A", true, { iss: "Simple API", algorithm: "HS256" }
    rescue JWT::VerificationError, JWT::DecodeError
      raise AuthenticationError
    end

    def render_unauthorized
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
end
