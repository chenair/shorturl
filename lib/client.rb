require 'activeresource'

  module Client
    class API
      class ShortUrl < ActiveResource::Base
        self.site = "http://localhost:3000"
      end
      

    end
  end
