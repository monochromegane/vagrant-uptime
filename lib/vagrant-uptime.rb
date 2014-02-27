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

    def self.show(uptimes, config, ui)
      uptime_sum = uptimes.inject(0) do |sum, u|
        sum + ( u[:down].to_i - u[:up].to_i )
      end

      hour = uptime_sum / (60*60) 
      min  = uptime_sum / 60
      sec  = uptime_sum

      ui.warn("Vagrant uptime: #{hour}h#{min}m (#{sec}s)")

      if config.cost > 0
        cost = config.cost * hour
        message = "Vagrant cost: $#{cost}"
        if cost >= config.alert
          ui.alert(message)
        else
          ui.warn(message)
        end
      end

    end

  end
end
