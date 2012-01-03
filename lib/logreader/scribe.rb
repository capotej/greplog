module Greplog
  module Logreader
    class Scribe < Base
      def all
        `ls -1 #{@basedir} | grep production`.split("\n")
      end
      #
      # need to abstract a "read" method that takes into account date ranges / multiple logs / bz(gz)cat
      def find_current(name)
        `cat #{@basedir}/#{name}/#{name}_current`
      end
     
      def find_in_current(name, thing)
        `cat #{@basedir}/#{name}/#{name}_current | grep #{thing}` 
      end

      def find_all(name)
        `ls -1 #{@basedir}/#{name}/`.split("\n")
      end

    end
  end
end
