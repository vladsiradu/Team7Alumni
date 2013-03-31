class Education < ActiveRecord::Base
  attr_accessible :id, :domain, :enrollment_date, :faculty_name, :graduation_date, :specialization, :university, :user_id
belongs_to :user
end
