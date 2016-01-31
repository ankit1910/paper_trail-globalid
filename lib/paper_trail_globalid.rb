require "paper_trail_globalid/paper_trail"
require "paper_trail_globalid/version"
require "paper_trail_globalid/version_concern"

module PaperTrailGlobalid
  module ::PaperTrail
    include ::PaperTrailGlobalid::PaperTrail
  end

  module ::PaperTrail
    module VersionConcern
      include ::PaperTrailGlobalid::VersionConcern
    end
  end
end
