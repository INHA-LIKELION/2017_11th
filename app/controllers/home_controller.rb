require 'open-uri'

class HomeController < ApplicationController
  def index
    @res = Result.all
  end

  def sendMail
    @email = params[:email]
    @title = params[:title]
    @content = params[:content]


    mg_client = Mailgun::Client.new("")

    message_params =  {
      from: 'hh@shorter.com',
      to:   @email,
      subject: @title,
      text:    @content
    }

    result = mg_client.send_message('', message_params).to_h!

    message_id = result['id']
    message = result['message']

    redirect_to '/'
  end

  def crawler
    url = "https://hanjungv.github.io/" # url을 지정해
    doc = Nokogiri::HTML(open(url)) # 열고
    @posts = doc.css('.posts-list article') #뽑아낸다

    @posts.each do |x| #각각 돌면서 Result에 추가해줍니다.
      tit = x.css('.post-title').text.strip
      cont = x.css('.post-entry-container .post-entry').text.strip
      @res = Result.new(title: tit, content: cont)
      @res.save
    end


    redirect_to '/'
  end
end
