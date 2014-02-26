module VagrantPlugins
  module Uptime
    module Action
      class Halt
        def initialize(app, env)
          @app = app
        end

        def call(env)
          @app.call(env)
          halt env
        end

        protected

        def halt(env)
          uptimes = VagrantPlugins::Uptime.uptimes
          uptimes.last[:down] = Time.now
          VagrantPlugins::Uptime.uptimes = uptimes

          uptime_sum = uptimes.inject(0) do |sum, u|
            sum + ( u[:down].to_i - u[:up].to_i )
          end

          hour = uptime_sum / (60*60) 
          min  = uptime_sum / 60
          sec  = uptime_sum

          env[:ui].warn("Vagrant uptime: #{hour}h#{min}m (#{sec}s)")

          config = env[:machine].config.uptime
          if config.cost > 0
            cost = config.cost * hour
            message = "#{env[:machine].provider_name} cost: #{cost}$"
            if cost >= config.alert
              env[:ui].alert(message)
            else
              env[:ui].warn(message)
            end
          end
        end
      end
    end
  end
end
