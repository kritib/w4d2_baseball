class Team < ActiveRecord::Base
  set_table_name :Teams
  set_primary_keys :teamID, :yearID, :lgID

  has_many :playerships, :foreign_key => [:teamID, :yearID, :lgID]
  has_many :players, :through => :playerships

  has_many :managerships, :foreign_key => [:teamID, :yearID, :lgID]
  has_many :managers, :through => :managerships

  def self.most_improved(num_years = 2)
    self
      .select("Teams.*, later.W-Teams.W AS improvement")
      .joins("JOIN Teams AS later ON later.teamID = Teams.teamID
                              AND later.yearID = (Teams.yearID + #{num_years-1})")
      .where("later.W > Teams.W")
      .group("Teams.teamID, later.teamID")
      .order("improvement DESC")
      .limit(5)
  end

  def self.most_moved
    self
      .select("Teams.*, COUNT(DISTINCT(park)) AS num_locations")
      .group(:teamID)
      .order("num_locations DESC")
      .first
  end
end