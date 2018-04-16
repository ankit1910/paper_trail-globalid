module PaperTrailGlobalid
  module PaperTrail
    def whodunnit=(value)
      if value.respond_to?(:to_gid)
        paper_trail_store[:whodunnit] = value.to_gid
      else
        paper_trail_store[:whodunnit] = value
      end
    end

    def actor
      ::GlobalID::Locator.locate(paper_trail_store[:whodunnit]) || whodunnit
    end
  end
end
