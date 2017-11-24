require 'msgmaker'
require 'parser'

class KakaoController < ApplicationController
  
  @@keyboard = Msgmaker::Keyboard.new
  @@message = Msgmaker::Message.new
  
  def keyboard
    render json: @@keyboard.getBtnKey(["영화","고양이","기타"])
  end

  def message
    basic_keyboard = @@keyboard.getBtnKey(["영화","고양이","기타"])
    
    user_msg = params[:content]
    msg = "기본 메세지 입니다."
    
    if user_msg == "고양이"
      parse = Parser::Animal.new
       # => 고양이 url을 가지고 있음
      message = @@message.getPicMessage("나만고양이없어", parse.cat)
      
    elsif user_msg == "영화"
      parse = Parser::Movie.new
      message = @@message.getMessage(parse.naver + [ "보던가 말던가", "강추", "재밌대.." ].sample) 
    else
      message = @@message.getMessage("없는 명령어 입니다.")
    end
    
    result = {
      message: message,
      keyboard: basic_keyboard
    }
   
    render json: result
  end
  
  def friend_add
    User.create(user_key: params[:user_key], chat_room: 0)	
    render nothing: true
    # 새로운 유저를 생성
  end
  
  def friend_del
    # 유저를 삭제
    user = User.find_by(user_key: params[:user_key])	
    user.destroy
    render nothing: true
  end
  
  def chat_room
    user = User.find_by(user_key: params[:user_key])	
    user.plus
    user.save
    render nothing: true
    # chat_room 0 +1 +1
  end
end