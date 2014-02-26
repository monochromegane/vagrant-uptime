require "vagrant/uptime/version"

module Vagrant
  module Uptime
    class Plugin < Vagrant.plugin("2")
      name "Vagrant Uptime"
    end
  end
end
