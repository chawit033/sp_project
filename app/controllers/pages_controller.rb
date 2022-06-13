class PagesController < ApplicationController

    def home
        render json: { "hello": "welcome" }

    end

    def landing
        if authenticate
            render json: { "hello": "you are logged in" }
        else
            render json: { message: "Your ID or password is incorrect" }
        end
    end

end