class PageController < ActionController::Base
  
  def index
    if params[:code].blank?
      # The short url is not valid
      render :text => "This is not a valid URL, please check the URL you are supposed to visit and try again."
    else
      url = Url.find_by shorturl: params[:code].upcase
      
      if url
        redirctUrl = url.originalurl
        
        if !redirctUrl.start_with?('http://') && !redirctUrl.start_with?('https://')
          redirctUrl = 'http://' + redirctUrl
        end
        
        redirect_to redirctUrl
      else
        # The short url is not valid
        render :text => "This is not a valid URL, please check the URL you are supposed to visit and try again."
      end
    end 
  end
  
end
