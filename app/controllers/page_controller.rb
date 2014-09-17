class PageController < ActionController::Base
  
  def index
    @redirctUrl = ""
    
    if params[:code].blank?
      # The short url is not valid
    else
      url = Url.find_by shorturl: params[:code].upcase
      
      if url
        @redirctUrl = url.originalurl
        
        if !@redirctUrl.start_with?('http://') && !@redirctUrl.start_with?('https://')
          @redirctUrl = 'http://' + @redirctUrl
        end
      else
        # The short url is not valid
      end
    end 
  end
  
end
