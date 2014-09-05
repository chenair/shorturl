class ShorturlController < ActionController::Base
  
  def home
  end
  
  def service
  end
  
  def show
    # CORS
    headers['Access-Control-Allow-Origin'] = "*"
    
    inputUrl = request.query_string
    
    if inputUrl.blank?
      respond_to do |format|
         format.xml { render :xml => '<error>Invalid original url</error>' }
         format.json { render :json => {error: "Invalid original url"} }
      end
      return
    end
    
    url = Url.find_by originalurl: inputUrl
    
    if url
      respond_to do |format|
         format.xml { render :xml => '<shorturl>'+Rails.configuration.ent_url_base + url.shorturl+'</shorturl>' }
         format.json { render :json => {shorturl: Rails.configuration.ent_url_base + url.shorturl} }
      end
    else
      code = ""
      
      for i in 0..2
        code = generateCode(6)
        
        existUrl = Url.find_by shorturl: code
        
        if existUrl
          # code already exists in db, need to regenerate
          code = ""
        else
          break
        end
      end
      
      if code == ""
        respond_to do |format|
           format.xml { render :xml => '<error>Duplicate short url</error>' }
           format.json { render :json => {error: "Duplicate short url"} }
        end
        return
      end
      
      @url = Url.create shorturl: code, originalurl: inputUrl
      
      respond_to do |format|
        format.xml { render :xml => '<shorturl>'+Rails.configuration.ent_url_base + @url.shorturl+'</shorturl>' }
        format.json { render :json => {shorturl: Rails.configuration.ent_url_base + @url.shorturl} }
      end
    end
  end
  
  def generateCode(len)
    chars = ("a".."z").to_a + ("0".."9").to_a + ("A".."Z").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(0...chars.size)] }
    return newpass
  end
  
end
