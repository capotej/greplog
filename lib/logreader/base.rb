#base log reader class, implement this to handle your log dirs/logs

module Greplog
  module Logreader
    class Base
      def initialize
        @basedir = Greplog::Config.config[:logdir]
      end
      def all
      end
    end
  end
end
