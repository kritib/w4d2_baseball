class Person < ActiveRecord::Base
  set_table_name(:Master)
  set_primary_key(:lahmanID)

  has_many :pitching_lines, :foreign_key => "playerID", :primary_key => "playerID"
  has_many :batting_lines, :foreign_key => "playerID", :primary_key => "playerID"

  has_many :playerships, :foreign_key => "playerID", :primary_key => "playerID"
  has_many :teams, :through => :playerships

  has_many :managerships, :foreign_key => "managerID", :primary_key => "managerID"
  has_many :managed_teams, :source => :team, :through => :managerships

  has_many :salaries, :foreign_key => "playerID", :primary_key => "playerID"
end