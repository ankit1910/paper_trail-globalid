require "paper_trail_globalid/paper_trail"
require "paper_trail_globalid/version"
require "paper_trail_globalid/version_concern"

module PaperTrailGlobalid
  module ::PaperTrail
    class << self
      prepend ::PaperTrailGlobalid::PaperTrail
    end
  end

  module ::PaperTrail
    module Request
      class << self
        prepend ::PaperTrailGlobalid::PaperTrail
      end
    end
  end

  module ::PaperTrail
    module VersionConcern
      include ::PaperTrailGlobalid::VersionConcern
    end
  end
end
