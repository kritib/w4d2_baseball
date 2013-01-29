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

  def self.most_players_managed
    self
      .select("Master.*, COUNT(DISTINCT(managed.playerID)) AS num_players_managed")
      .joins(:managed_teams => :playerships)
      .joins("JOIN Master AS managed ON managed.playerID = Appearances.playerID")
      .group("Master.managerID")
      .order("num_players_managed DESC")
      .first
  end

  def self.managed_and_played
    self
      .where("playerID != ''")
      .where("managerID != ''")
  end

  def self.most_team_transfers_in_a_year
    self
      .select
      .join
      .group([:teams, :person])
  end

  def self.only_played_in_one_team
    players = self
      .select("Master.*, COUNT(DISTINCT(Teams.teamID)) AS num_teams")
      .joins(:teams)
      .group(:playerID)
      .select {|player| player.num_teams == 1}
  end

  def self.played_for_num_years(num_years)
    self
      .select("Master.*, (MAX(yearID) - MIN(yearID)) AS career_length")
      .joins(:playerships)
      .group("Master.playerID")
      .select { |player| player.career_length >= num_years }
  end

end




