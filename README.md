# 4차산업혁명 선도인재 양성 프로젝트 과정

---
## 1. Week 1 Day 15:   

***



##### 카카오톡 플러스친구 챗봇 with Ruby on Rails



카카오톡 플러스친구 api

https://github.com/plusfriend/auto_reply

##### 5.1. Home Keyboard API

keyboard 호출 



1. rails g controller [프로젝트명] keyboard message

2. json & ruby hash로 변경

   ```ruby
   def keyboard
     keyboard = {
         :type => "buttons",
         :buttons => ["선택 1", "선택 2", "선택 3"]
     }
     render json: keyboard
   end

   ```

3. routes.rb 에서 keyboard로 보내도록 라우트 정리

```ruby
get 'keyboard' => 'kakaochatbot#keyboard'
```

4. message 전송

```ruby
  def message
    user_msg = params[:content]
    result = {
    "message" => {
        "text" => user_msg
    }
  }
  
  render json: result
```



##### 랜덤이미지

gem 'nokogiri'

gem 'rest-client'



type jpg 강제로

http://thecatapi.com/api/images/get?format=xml&results_per_page=1&type=jpg



### Module

+ 모듈은 정리정돈

ruby code.rb

인스턴스화

```ruby
module Dohyun
  module_function()
  
  class Lion
    def go
      puts '코딩하고싶다'
    end
  end    
end

def go
  puts '집에가고싶다'
end

a = Dohyun:Lion.go.new
a.go

```



post로 friend url 요청하면 kakao의 frend_add을 실행

```ruby
post '/friend' => 'kakao#friend_add'
delete '/friend' => 'kakao#friend_del'
delete '/chat_room/:user_key' => 'kakao#chat_room'
```

```ruby
def friend_add
end
```



/app/helpers/msgmaker.rb

```ruby
module Msgmaker
    class Keyboard

        def getTextKey
            
            json = {
                "type": "text"
            }
            return json
        end
        
        def getBtnKey(*arg)
        
            json = {
              "type": "buttons",
                "buttons": []
            }
            
            arg.each do |a|
                json[:buttons] = a
            end
            return json
        end
    end
```



/app/helpers/parser.rb



keep counting.. += 1

```ruby
class User < ActiveRecord::Base
    def plus
        self.chat_room += 1
    end
end
```



#### 5.3. 친구 추가/차단/삭제 카운팅 API

rails g model user chat_room:integer user_key

add, del, chat_room 

find_by로 찾아서

```ruby
User.create(user_key: params[:user_key], chat_room: 0)	
render nothing: true
```



delete또한 :user_key 추가 필요

```ruby
delete '/friend/:user_key' => 'kakao#friend_del'
```

