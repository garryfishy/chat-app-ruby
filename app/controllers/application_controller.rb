class ApplicationController < ActionController::API
    def test
        @user = User.all
        render json: @user

    end

    # JWT START
    def authentication
        # making a request to a secure route, token must be included in the headers
        decode_data = decodeToken(request.headers["token"])

        if !decode_data
            return false
        end

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


    def login
        # p "masuk sini"
        @findUser = User.find_by(username: params["username"])

        if @findUser
            if @findUser.password == params["password"]
                token = encodeToken({id: @findUser.id, username: @findUser.username})
                render json: {msg: 'masuk', code: 200, token: token}
            else
                render json:{
                    msg: "Check your username / password",
                    code: 400
                }, status: 400
            end
        else
            render json: {
                msg: "User not found",
                code: 404
            }, status: 404
            
        end        
    end

    # before_action :authentication

    def getMessage(senderId, recieverId)
        # getChat chat
        findChat = Chat.where("(senderID = #{senderId} AND recieverId = #{recieverId}) OR (senderId = #{recieverId} AND recieverId = #{senderId})")

        if findChat.length > 0
            return findChat
        else
            render json: {
                msg: 'Empty chat room',
                code: 200
            }

        end

        # p "masu"
    
    end

    def sendMessage
        if authentication
            recieverId = params["id"].to_i
            checkUser = User.find_by(id: recieverId)

            if checkUser
                decode_data = decodeToken(request.headers["token"])
                senderId = decode_data[0]["id"]
                message = params["message"]\

                data = {
                    senderId: senderId,
                    recieverId: recieverId,
                    message: message
                }

                findChat = getMessage(senderId, recieverId)
                # createChat = Chat.create(data)
                # p createChat
                render json: findChat
            end

        else
            render json: {
                msg: "Please login", code: 401
            }, status: 401
        end
    end





end
