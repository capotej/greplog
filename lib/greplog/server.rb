module Greplog
  class Server < EM::Connection
    include EM::HttpServer

    def post_init
      super
      @@reader ||= Greplog::Reader.new
      no_environment_strings
    end
    
    def self.start
      puts "starting server on " << Greplog::Config.config[:ip] << ":" << Greplog::Config.config[:port]
      EM.run{
        EM.start_server Greplog::Config.config[:ip], Greplog::Config.config[:port], self
      }
    end
   
    def process_http_request
      # the http request details are available via the following instance variables:
      #   @http_protocol
      #   @http_request_method
      #   @http_cookie
      #   @http_if_none_match
      #   @http_content_type
      #   @http_path_info
      #   @http_request_uri
      #   @http_query_string
      #   @http_post_content
      #   @http_headers
      case @http_request_uri
      when "/" 
        index_page
      #subdir view
      when /\/log\/([^\/]+)\/current\/find\/([^\/]+)/
        find_view($1, $2)
      when /\/log\/([^\/]+)\/current/
        current_view($1) 
      #dir view
      when /\/log\/([^\/]+)/
        dir_view($1) 
      else
        index_page
      end
    end

    def current_view(name)
      html_response @@reader.find_current(name)
    end
   
    def find_view(name, thing)
      html_response @@reader.find_in_current(name, thing)
    end
    def dir_view(name)
      html_response @@reader.find_all(name)
    end
    
    def index_page
      html_response @@reader.all.map { |x| "<a href=\"/log/#{x}\">#{x}</a><br/>" }.join('')
    end

    def html_response(content)
      response = EM::DelegatedHttpResponse.new(self)
      response.status = 200
      response.content_type 'text/html'
      response.content = content
      response.send_response
    end
  end
end
