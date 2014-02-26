module VagrantPlugins
  module Uptime
    class CostConfig < Vagrant.plugin("2", "config")
      attr_accessor :cost, :alert
    end
  end
end
