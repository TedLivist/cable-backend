module Api
  class ChatsController < ApplicationController

    def index
      chats = Chat.all
      render json: chats
    end

    def create
      chat = Chat.create(chat_params)

      if chat.save
        ActionCable.server.broadcast('message_channel', chat )
      end
    end

    private

    def chat_params
      params.require(:chat).permit(:text, :username)
    end
  end
end