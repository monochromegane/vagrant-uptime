module VagrantPlugins
  module Uptime
    class Plugin < Vagrant.plugin("2")
      name "Vagrant Uptime"
      description "Show Vagrant uptime."

      action_hook("up", 'machine_action_up') do |hook|
        require_relative "action/up"
        hook.prepend(Action::Up)
      end
    end
  end
end

