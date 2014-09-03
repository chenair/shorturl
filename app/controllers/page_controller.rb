class PageController < ActionController::Base
  
  def index
    if params[:code].blank?
    else
      url = Url.find_by shorturl: params[:code]
      if url
        redirctUrl = url.originalurl
        
        if !redirctUrl.start_with?('http://') && !redirctUrl.start_with?('https://')
          redirctUrl = 'http://' + redirctUrl
        end
        
        redirect_to redirctUrl
      end
    end 
  end
  
end
