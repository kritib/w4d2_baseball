class Team < ActiveRecord::Base
  set_table_name :Teams

  has_many :playerships, :foreign_key => "teamID", :primary_key => "teamID"
  has_many :players, :through => :playerships
  has_many :managerships
end