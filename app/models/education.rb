class Education < ActiveRecord::Base
  attr_accessible :domain, :enrollment_date, :faculty_name, :graduation_date, :specialization, :university, :user_id
belongs_to :user
end
