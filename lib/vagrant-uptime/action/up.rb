module VagrantPlugins
  module Uptime
    module Action
      class Up
        def initialize(app, env)
          @app = app
        end

        def call(env)
          puts "--> Called!"
          @app.call(env)
          puts "<-- Called!"
        end
      end
    end
  end
end
