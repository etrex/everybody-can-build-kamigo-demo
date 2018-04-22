class PushMessagesController < ApplicationController
  before_action :authenticate_user!

  # GET /push_messages/new
  def new
  end

  # POST /push_messages
  def create
    text = params[:text]
    Channel.all.each do |channel|
      push_to_line(channel.channel_id, text)
    end
    redirect_to '/push_messages/new'
  end

  # 傳送訊息到line
  def push_to_line(channel_id, text)
    return nil if channel_id.nil? or text.nil?

    # 設定回覆訊息
    message = {
      type: 'text',
      text: text
    }

    # 傳送訊息
    line.push_message(channel_id, message)
  end

  # Line Bot API物件初始化
  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = '9160ce4f0be51cc72c3c8a14119f567a'
      config.channel_token = '2ncMtCFECjdTVmopb/QSD1PhqM6ECR4xEqC9uwIzELIsQb+I4wa/s3pZ4BH8hCWeqfkpVGVig/mIPDsMjVcyVbN/WNeTTw5eHEA7hFhaxPmQSY2Cud51LK PPiXY+nUi+QrXy0d7Hi2YUs65B/tVOpgdB04t89/1O/w1cDnyilFU='
    }
  end
end