class Subject < ActiveRecord::Base
  attr_accessible :pointer
  has_many :trials
end
