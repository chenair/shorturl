class ShorturlController < ActionController::Base
  
  def home
  end
  
  def service
  end
  
  def show
    if params[:url].blank?
      respond_to do |format|
         format.xml { render :xml => '<error>This is invalid url.</error>' }
      end
      return
    end
    
    url = Url.find_by originalurl: 'http://'+params[:url]
    if url
      respond_to do |format|
         format.xml { render :xml => '<error>This is existing url.</error>' }
      end
    else
      #code = ('A'..'Z').to_a.shuffle[0,1].join + rand.to_s[1..1]
      code = generateCode(6)
      @url = Url.create shorturl: code, originalurl: params[:url]
      respond_to do |format|
        format.xml { render :xml => '<shorturl>'+Rails.configuration.ent_url_base+'?'+@url.shorturl+'</shorturl>' }
     end
    end
  end
  
  def generateCode(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  
end
