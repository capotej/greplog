module Greplog
  class Config
    def self.load_config
      $config = self.user_config
    end

    def self.config
      $config
    end
    
    def self.default_config
      { :ip => '0.0.0.0', :port => '8080', :logdir => "log/", :logclass => "Scribe" }
    end

    def self.user_config
      config_file = "#{ENV['HOME']}/.greplog"
      if File.exists? config_file
        puts "found config file ~/.greplog, loading..."
        YAML.load_file(config_file)
      else
        puts "no config file found, creating default in ~/.greplog"
        File.open(config_file, "w") do |file| 
          file.print self.default_config.to_yaml
        end
      end
    end
  end
end
