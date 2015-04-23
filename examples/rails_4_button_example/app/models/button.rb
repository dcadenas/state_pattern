class Button < ActiveRecord::Base
  include StatePattern::ActiveRecord
  set_initial_state On
end
