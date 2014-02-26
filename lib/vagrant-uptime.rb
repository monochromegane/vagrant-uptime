require "yaml"
require "pathname"
require "vagrant-uptime/version"
require "vagrant-uptime/plugin"

module VagrantPlugins
  module Uptime
    def self.uptime_file
      Pathname.pwd.join(".vagrant/uptime.yml")
    end

    def self.uptimes
      file = self.uptime_file
      file.exist? ? YAML.load_file(file) : []
    end

    def self.uptimes=(uptimes)
      self.uptime_file.open("w") do |f|
        YAML.dump(uptimes, f)
      end
    end
  end
end
