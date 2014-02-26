module VagrantPlugins
  module Uptime
    module Action
      class Up
        def initialize(app, env)
          @app = app
        end

        def call(env)
          up
          @app.call(env)
        end

        protected

        def up
          uptimes = VagrantPlugins::Uptime.uptimes
          uptimes << { up: Time.now }
          VagrantPlugins::Uptime.uptimes = uptimes
        end
      end
    end
  end
end
