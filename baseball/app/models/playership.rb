class Playership < ActiveRecord::Base
  set_table_name :Appearances

  belongs_to :player, :class_name => 'Person',
        :foreign_key => "playerID", :primary_key => "playerID"
  belongs_to :team, :foreign_key => "teamID", :primary_key => "teamID"
end