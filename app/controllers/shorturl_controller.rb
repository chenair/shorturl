class ShorturlController < ActionController::Base
  
  def home
  end
  
  def service
  end
  
  def show 
    inputUrl = request.query_string
    
    if inputUrl.blank?
      respond_to do |format|
         format.xml { render :xml => '<error>Invalid URL</error>' }
      end
      return
    end
    
    url = Url.find_by originalurl: inputUrl
    
    if url
      respond_to do |format|
         format.xml { render :xml => '<shorturl>'+Rails.configuration.ent_url_base+'?code='+url.shorturl+'</shorturl>' }
      end
    else
      code = generateCode(6)
      
      @url = Url.create shorturl: code, originalurl: inputUrl
      
      respond_to do |format|
        format.xml { render :xml => '<shorturl>'+Rails.configuration.ent_url_base+'?code='+@url.shorturl+'</shorturl>' }
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
