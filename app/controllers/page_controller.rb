class PageController < ActionController::Base
  
  def index
    if params[:code].blank?
    else
      url = Url.find_by shorturl: params[:code]
      if url
        redirect_to 'http://'+ url.originalurl
      end
    end 
  end
  
end
