source :rubygems

gem 'rake'

group :test do
  gem 'activerecord', '~> 3'
  gem 'expectations'
  gem 'activerecord-nulldb-adapter', :git => 'https://github.com/dcadenas/nulldb.git'
end

