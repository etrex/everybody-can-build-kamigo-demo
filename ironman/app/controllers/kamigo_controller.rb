require 'line/bot'
class KamigoController < ApplicationController
  protect_from_forgery with: :null_session

  def webhook
    # 學說話
    reply_text = learn(received_text)

    # 設定回覆文字
    reply_text = keyword_reply(received_text) if reply_text.nil?

    # 傳送訊息到line
    response = reply_to_line(reply_text)

    # 回應200
    head :ok
  end

  # 取得對方說的話
  def received_text
    message = params['events'][0]['message']
    message['text'] unless message.nil?
  end

  # 學說話
  def learn(received_text)
    #如果開頭不是 卡米狗學說話; 就跳出
    return nil unless received_text[0..6] == '卡米狗學說話;'

    received_text = received_text[7..-1]
    semicolon_index = received_text.index(';')

    # 找不到分號就跳出
    return nil if semicolon_index.nil?

    keyword = received_text[0..semicolon_index-1]
    message = received_text[semicolon_index+1..-1]

    KeywordMapping.create(keyword: keyword, message: message)
    '好哦∼好哦∼'
  end

  # 關鍵字回覆
  def keyword_reply(received_text)
    KeywordMapping.where(keyword: received_text).last&.message
  end

  # 傳送訊息到line
  def reply_to_line(reply_text)
    return nil if reply_text.nil?

    # 取得reply token
    reply_token = params['events'][0]['replyToken']

    # 設定回覆訊息
    message = {
      type: 'text',
      text: reply_text
    }

    # 傳送訊息
    line.reply_message(reply_token, message)
  end

  # Line Bot API物件初始化
  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = '9160ce4f0be51cc72c3c8a14119f567a'
      config.channel_token = '2ncMtCFECjdTVmopb/QSD1PhqM6ECR4xEqC9uwIzELIsQb+I4wa/s3pZ4BH8hCWeqfkpVGVig/mIPDsMjVcyVbN/WNeTTw5eHEA7hFhaxPmQSY2Cud51LK PPiXY+nUi+QrXy0d7Hi2YUs65B/tVOpgdB04t89/1O/w1cDnyilFU='
    }
  end

  def eat
    render plain: "吃土啦"
  end

  def request_headers
    render plain: request.headers.to_h.reject{ |key, value|
      key.include? '.'
    }.map{ |key, value|
      "#{key}: #{value}"
    }.sort.join("\n")
  end

  def response_headers
    response.headers['5566'] = 'QQ'
    render plain: response.headers.to_h.map{ |key, value|
      "#{key}: #{value}"
    }.sort.join("\n")
  end

  def request_body
    render plain: request.body
  end

  def show_response_body
    puts "===這是設定前的response.body:#{response.body}==="
    render plain: "虎哇花哈哈哈"
    puts "===這是設定後的response.body:#{response.body}==="
  end

  def sent_request
    uri = URI('http://localhost:3000/kamigo/eat')
    http = Net::HTTP.new(uri.host, uri.port)
    http_request = Net::HTTP::Get.new(uri)
    http_response = http.request(http_request)

    render plain: JSON.pretty_generate({
      request_class: request.class,
      response_class: response.class,
      http_request_class: http_request.class,
      http_response_class: http_response.class
    })
  end

  def translate_to_korean(message)
    "#{message}油~"
  end
end