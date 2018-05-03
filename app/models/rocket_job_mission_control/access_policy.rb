module RocketJobMissionControl
  class AccessPolicy
    include AccessGranted::Policy

    def configure
      # Destroy Jobs, Dirmon Entries
      role :admin, {admin: true} do
        can %i[create destroy], Job
        can :destroy, DirmonEntry
      end

      # View the contents of jobs and edit the data within them.
      # Including encrypted records.
      role :editor, {editor: true} do
        can %i[read_records update_records], Job
      end

      # Stop, Pause, Resume, Destroy (force stop) Rocket Job Servers
      role :operator, {operator: true} do
        can %i[stop pause resume destroy], Server
      end

      # Pause, Resume, Retry, Abort, Edit Jobs
      role :manager, {manager: true} do
        can %i[edit pause resume retry abort update], Job
      end

      # Create, Enable, Disable, Edit Dirmon Entries
      role :dirmon, {dirmon: true} do
        can %i[create enable disable update], DirmonEntry
      end

      # A User can only edit their own jobs
      role :user, {user: true} do
        can %i[edit pause resume retry abort update], Job do |job, user|
          job.respond_to?(:login) && (job.login == user.login)
        end
      end

      # Read only access
      role :view do
        can :read, Job
        can :read, DirmonEntry
        can :read, Server
        can :read, Worker
      end
    end
  end
end
