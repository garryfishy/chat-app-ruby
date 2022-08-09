class ApplicationController < ActionController::API

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

    # method for logging in

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

    # Method to get Chat between two users

    def getMessage(senderId, recieverId)
        findChat = Chat.where("(senderID = #{senderId} AND recieverId = #{recieverId}) OR (senderId = #{recieverId} AND recieverId = #{senderId})")

        if findChat.length > 0
            return findChat
        else
            return {
                msg: 'Empty chat room',
                code: 200
            }
        end

    end

    # Method to get chat between two users

    def getChat
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

    # Method to get all messages user included in

    def getMine
        if authentication
            decode_data = decodeToken(request.headers["token"])
            id = decode_data[0]["id"]
            getMyChat = Chat.where("senderId = #{id} OR recieverId = #{id}")

            if getMyChat.length > 0
                render json: getMyChat, status 200
            else
                render json: {
                    msg: "No messages found",
                    code: 404
                }, status 404
        else
            render json: {
                msg: "Please login", code: 401
            }, status: 401
        end
    end

    # Method to send message between two users

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

                createChat = Chat.create(data)

                if createChat
                    findChat = getMessage(senderId, recieverId)
                    # p createChat
                    render json: findChat
                end

            end

        else
            render json: {
                msg: "Please login", code: 401
            }, status: 401
        end
    end

end
