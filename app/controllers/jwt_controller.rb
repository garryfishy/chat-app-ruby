class JWTController < ApplicationController
    # JWT START
    def authentication
        # making a request to a secure route, token must be included in the headers
        decode_data = decodeToken(request.headers["token"])
        # getting user id from a nested JSON in an array.
        user_data = decode_data[0]["id"] unless !decode_data
        # find a user in the database to be sure token is for a real user
        user = User.find_by(id: user_data)
    
        # The barebone of this is to return true or false, as a middleware
        # its main purpose is to grant access or return an error to the user
    
        if user
          return true
        else
          render json: { message: "invalid credentials" }
        end
    end

    def encodeToken(payload)
        return JWT.encode(payload, 'secretcode')
    end

    def decodeToken(token)
        return JWT.decode(token, 'secretcode')
    end
    # JWT END
end
