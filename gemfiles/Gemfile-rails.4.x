source 'https://rubygems.org'

gem 'rake'

group :test do
  gem 'activerecord', '~> 4'
  gem 'minitest'
  gem 'expectations'
  gem 'activerecord-nulldb-adapter', git: "https://github.com/joongimin/nulldb.git"
end

