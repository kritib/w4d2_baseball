class Batting < ActiveRecord::Base
  set_table_name :Batting

  belongs_to :batter, :class_name => 'Person', :foreign_key => "playerID", :primary_key => "playerID"
end