module Greplog
  module Logreader
    class Scribe < Base
      def all
        `ls #{@basedir} -1 | grep production`
      end

      def find_current(name)
        `cat #{@basedir}/#{name}/#{name}_current`
      end
    end
  end
end
