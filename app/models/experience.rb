class Experience < ActiveRecord::Base
  attr_accessible :city, :company, :country, :description, :end_date, :job_title, :start_date, :user_id
belongs_to :user
end
