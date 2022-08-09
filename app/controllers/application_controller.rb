class ApplicationController < ActionController::API
    def test
        @user = chat.all
        render json: @user

    end
end
