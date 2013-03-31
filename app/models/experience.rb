class Experience < ActiveRecord::Base
  attr_accessible :id, :city, :company, :country, :description, :end_date, :job_title, :start_date, :user_id
belongs_to :user
end
