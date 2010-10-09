::ActiveRecord::Schema.define do
  create_table "ar_buttons" do |t|
    t.integer  "button_id"
    t.string   "state"
    t.string   "state2"
  end
end
