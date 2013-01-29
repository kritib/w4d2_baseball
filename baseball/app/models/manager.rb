class Manager < ActiveRecord::Base
  set_table_name :Managers
  set_primary_key :managerID

  belongs_to :person, :foreign_key => "managerID", :primary_key => "managerID"
end