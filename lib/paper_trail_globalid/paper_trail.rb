module PaperTrailGlobalid
  module PaperTrail
    module ClassMethods
      def whodunnit=(value)
        if value.is_a? ActiveRecord::Base
          paper_trail_store[:whodunnit] = value.to_gid
        else
          paper_trail_store[:whodunnit] = value
        end
      end

      def actor
        ::GlobalID::Locator.locate(paper_trail_store[:whodunnit]) || whodunnit
      end
    end

    def self.included(receiver)
      receiver.extend ClassMethods
    end
  end
end
