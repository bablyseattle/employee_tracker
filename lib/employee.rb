class Employee < ActiveRecord::Base
  belongs_to(:departments)
end
