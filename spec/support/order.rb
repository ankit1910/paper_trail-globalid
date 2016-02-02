require 'paper_trail'
require 'paper_trail-globalid'
class Order < ActiveRecord::Base
  has_paper_trail
end
