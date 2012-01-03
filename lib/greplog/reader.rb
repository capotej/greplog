module Greplog
  class Reader
    attr_accessor :proxy 
    
    def initialize
      p "iniinininasd"
      logclass = Greplog::Config.config[:logclass]
      obj = Greplog::Util.constantize(logclass)
      @proxy = obj.new
    end
  
    private
    def method_missing(method_sym, *arguments, &block)
      puts "[reader] sending #{method_sym}" 
      @proxy.send(method_sym, *arguments, &block) 
    end

    def respond_to(method_sym, include_private = false)
      true
    end
  end
end
