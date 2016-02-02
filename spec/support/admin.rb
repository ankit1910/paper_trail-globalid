require 'globalid'
class Admin < ActiveRecord::Base
  include ::GlobalID::Identification
end
