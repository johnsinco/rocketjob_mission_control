module RocketJobMissionControl
  class Authorization
    ROLES = %i[admin editor operator manager dirmon user view]
    attr_accessor *ROLES

    def initialize(roles: [], login: nil)
      invalid_roles = roles - ROLES
      raise(ArgumentError, "Invalid Roles Supplied: #{roles.inspect}") if invalid_roles

      roles.each { |role| public_send("#{role}=", true) }
    end
  end
end
