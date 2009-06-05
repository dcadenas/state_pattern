require 'test_helper'

module James
  protected

  def name
    transition_to(Lynn)
    "James #{last_name}"
  end
end

module Lynn
  protected

  def name
    transition_to(James)
    "Lynn #{last_name}"
  end
end

class FamilyMember
  include StatePattern
  add_states James, Lynn
  set_initial_state Lynn

  def name
    state_instance.name
  end

  def last_name
    "Holbrook"
  end
end

Expectations do
  expect "Lynn Holbrook" do
    member = FamilyMember.new
    member.name 
  end

  expect "James Holbrook" do
    member = FamilyMember.new
    member.name 
    member.name 
  end

  expect "Lynn Holbrook" do
    member = FamilyMember.new
    member.name 
    member.name 
    member.name 
  end
end


