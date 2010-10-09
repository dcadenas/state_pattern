require 'test_helper'
require 'active_record'

{
  "nulldb" => "active_record/connection_adapters/nulldb_adapter",
  "expectations" => "expectations"
}.each do |gem_name, require_arg|
  begin
    require require_arg
  rescue LoadError
    puts "You need to install the #{gem_name} gem to run the tests"
  end
end

#Nulldb expects Rails.root to be defined
class Rails
  def self.root
    File.dirname(__FILE__)
  end
end

ActiveRecord::Base.establish_connection :adapter => :nulldb, :schema => 'schema.rb'

require 'rails/init'
require 'state_pattern/active_record'
