module RocketJobMissionControl

  # The authorization callback
  module Config
    mattr_accessor :authorization_callback
  end

  class Engine < ::Rails::Engine
    isolate_namespace RocketJobMissionControl

    require 'rocketjob'
    require 'jquery-rails'
    require 'bootstrap-sass'
    require 'sass-rails'
    require 'jquery-datatables-rails'
    require 'access-granted'
    begin
      require 'rocketjob_pro'
    rescue LoadError
    end

    config.rocket_job_mission_control = ::RocketJobMissionControl::Config

    config.to_prepare do
      Rails.application.config.assets.precompile += %w(
        rocket_job_mission_control/rocket-icon-64x64.png
      )
    end
  end
end
