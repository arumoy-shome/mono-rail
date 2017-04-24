module ActiveRecord
  class Base
    def self.abstract_class=(params)
      #Not implemented
    end

    def initialize(params = {})
      @params = params
    end

    def id
      @params[:id]
    end

    def text
      @params[:text]
    end
  end
end
