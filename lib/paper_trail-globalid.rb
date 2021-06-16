require "paper_trail_globalid/paper_trail"
require "paper_trail_globalid/version"
require "paper_trail_globalid/version_concern"
require "paper_trail_globalid/rails/controller"

module PaperTrailGlobalid
  module ::PaperTrail
    class << self
      prepend ::PaperTrailGlobalid::PaperTrail
    end
  end
  module ::PaperTrail
    module VersionConcern
      include ::PaperTrailGlobalid::VersionConcern
    end
  end

  module ::PaperTrail
    module Rails
      module Controller
        if defined?(::ActionController)
          ::ActiveSupport.on_load(:action_controller) do
            include PaperTrailGlobalid::Rails::Controller
          end
        end
      end
    end
  end
end
