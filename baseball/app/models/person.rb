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

  def self.good_batters(avg = 0.3)
    players = self
      .select("Master.*, (SUM(Batting.H)/SUM(Batting.AB)) AS batting_avg")
      .joins(:batting_lines)
      .where("AB >= 100")
      .group("Batting.playerID")

    players.select { |player| player.batting_avg > avg }
  end

  def self.most_experienced
    self
      .select("Master.*, (MAX(yearID) - MIN(yearID)) AS career_length")
      .joins(:playerships)
      .group("Master.playerID")
      .order("career_length DESC")
  end
end