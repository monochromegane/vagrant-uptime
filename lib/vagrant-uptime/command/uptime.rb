module VagrantPlugins
  module Uptime
    class Uptime < Vagrant.plugin("2", "command")
      def execute
          uptimes = VagrantPlugins::Uptime.uptimes
          uptimes.last[:down] = Time.now
          VagrantPlugins::Uptime.show(uptimes, @env.config_global.uptime, @env.ui)
      end
    end
  end
end
