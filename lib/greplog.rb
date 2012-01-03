require 'rubygems'
require 'yaml'
require 'eventmachine'
require 'evma_httpserver'
require 'lib/greplog/server'
require 'lib/greplog/config'
require 'lib/logreader/base'

module Greplog

  class Util
    def self.load_modules
      Dir[File.expand_path(__FILE__ << "/../logreader/*")].each do |file|
        unless file.include?('base.rb')
          p "loading #{file}"
          load file
        end
      end
    end
  end
end
