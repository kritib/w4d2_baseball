class PitchingLine < ActiveRecord::Base
  set_table_name :Pitching

  belongs_to :pitcher, :class_name => 'Person',
        :foreign_key => "playerID", :primary_key => "playerID"
end