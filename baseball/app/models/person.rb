class Person < ActiveRecord::Base
  set_table_name(:Master)
  set_primary_key(:lahmanID)

  has_many :pitching_lines, :foreign_key => "playerID", :primary_key => "playerID"
  has_many :batting_lines, :foreign_key => "playerID", :primary_key => "playerID"
  has_many :playerships, :foreign_key => "playerID", :primary_key => "playerID"
end