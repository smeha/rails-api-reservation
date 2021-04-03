class ApplicationController < ActionController::API

	
	private
		# https://jwt.io/
		def authentication
			if request.headers["Authorization"].present?
				authorization_header = request.headers["Authorization"].split(' ')
				token = authorization_header.last.present? ? authorization_header.last : ''
				puts token.inspect
				JWT.decode token, "9C29AA3B6A47A440B20067DFF29F556EF22AD88A5D8F5E01F6B1A6962397C45A", true, {iss: 'Simple API', algorithm: 'HS256'}
			else
				raise CanCan::AccessDenied
			end

			rescue JWT::VerificationError, JWT::DecodeError
			raise CanCan::AccessDenied
		end
end
