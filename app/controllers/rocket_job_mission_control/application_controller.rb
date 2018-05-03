module RocketJobMissionControl
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    around_action :with_time_zone

    private

    def with_time_zone
      if time_zone = session['time_zone'] || 'UTC'
        Time.use_zone(time_zone) { yield }
      end
    end

    def current_policy
      @current_policy ||= begin
        args = Config.authorization_callback ? Config.authorization_callback.call(self) : {}
        AccessPolicy.new(Authorization.new(args))
      end
    end
  end
end
