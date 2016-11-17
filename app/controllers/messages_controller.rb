class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    # start: Move to some service which can create secure message
    @message = Message.create(message_params)
    @message.text = AESCrypt.encrypt(params[:message][:text], params[:message][:secret_code])
    @message.secret_code = params[:message][:secret_code]
    @message.save
    # end: Move to some service which can create secure message

    if @message.errors.empty?
      redirect_to link_message_path(@message.link)
    else
      redirect_to new_message_path
    end
  end

  def show
    # too many if conditions, move the logix to separated method or other Class
    @message = Message.find_by(link: params[:id])

    if params[:secret_code_input].nil?
      redirect_to message_verify_message_path(@message.link)
    else
      if @message.secret_code == params[:secret_code_input][:secret_code]
        @decrypted_message = AESCrypt.decrypt(@message.text, params[:secret_code_input][:secret_code])
      else
        redirect_to message_verify_message_path(@message.link)
        flash[:warning] = "Неверный пароль"
      end

      if @message.encryption_type == "Destroy message after the first link visit"
        if @message.is_visited == true
          @message.destroy
          redirect_to root_path
          flash[:warning] = "Сообщение было удалено"
        else
          @message.is_visited = true
          @message.save
        end
      else
        unless @message.created_at + 1.hour > Time.now # move to message instance method
          redirect_to root_path
        end
      end
    end
  end

  def message_verify
  end

  def link
    @message = Message.find_by(link: params[:id])
  end

private

  def message_params
    params.require(:message).permit(:text, :encryption_type, :secret_code_input)
  end
end
