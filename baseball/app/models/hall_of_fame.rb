class HallOfFame < ActiveRecord::Base
  set_table_name :HallOfFame

  belongs_to :person, :foreign_key => "hofID", :primary_key => "hofID"
end