class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)

    if @message.errors.empty?
      redirect_to link_path
    else
      redirect_to new_message_path
    end
  end

  def show
    @message = Message.find_by(link: params[:id])
  end

  def link
    @message = Message.last
  end

private

  def message_params
    params.require(:message).permit(:text, :encryption_type)
  end
end
