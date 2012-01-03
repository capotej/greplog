require 'rubygems'
require 'yaml'
require 'eventmachine'
require 'evma_httpserver'
require 'lib/greplog/config'
require 'lib/greplog/reader'
require 'lib/greplog/server'
require 'lib/logreader/base'

#bundled loggers
require 'lib/logreader/scribe'
#require 'lib/logreader/rails'


module Greplog

  class Util
    def self.load_external_loggers
    end
    def self.constantize(camel_cased_word)
      names = camel_cased_word.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  end
end

Greplog::Config.load_config
Greplog::Util.load_external_loggers
