# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_some_rails_app_session',
  :secret      => '0d24a5e18152cffd95957b774263ea448c85f43d1db9969c5d7aee3ba60e7fe768a1af9dc10a0d7ab4bae9ade440eeb8c3723f2e4c4e5eafc893ca0527b71687'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
