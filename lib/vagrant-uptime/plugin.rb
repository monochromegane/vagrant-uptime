module VagrantPlugins
  module Uptime
    class Plugin < Vagrant.plugin("2")
      name "Vagrant Uptime"
      description "Show Vagrant uptime."

      config "uptime" do
        require_relative "config/cost_config"
        CostConfig
      end

      command "uptime" do
        require_relative "command/uptime"
        Uptime
      end

      action_hook("up", 'machine_action_up') do |hook|
        require_relative "action/up"
        hook.prepend(Action::Up)
      end

      action_hook("halt", 'machine_action_halt') do |hook|
        require_relative "action/halt"
        hook.prepend(Action::Halt)
      end
    end
  end
end

