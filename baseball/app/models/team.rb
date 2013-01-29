class Team < ActiveRecord::Base
  set_table_name :Teams
  set_primary_keys :teamID, :yearID, :lgID

  has_many :playerships, :foreign_key => [:teamID, :yearID, :lgID]
  has_many :players, :through => :playerships

  has_many :managerships, :foreign_key => [:teamID, :yearID, :lgID]
  has_many :managers, :through => :managerships
end