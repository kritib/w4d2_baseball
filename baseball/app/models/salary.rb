class Salary < ActiveRecord::Base
  set_table_name :Salaries

  belongs_to :person, :foreign_key => "playerID", :primary_key => "playerID"
end