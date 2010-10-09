# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_2_3_8_button_example_session',
  :secret      => 'ad6183a3b2058c7aab51c1e7a8071ed29b60c83e91d72f890dd508f3d5374251e31a093cf29a7d40f987caa7f59a775a797b29f3ce514d2863df4924cb8f17c3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
