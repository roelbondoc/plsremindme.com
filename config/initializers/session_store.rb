# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_plsremindme_session',
  :secret      => '5994bc14b9601fd8ce5fe37819e3614d1a2025e063c34d54f16b3d5efcce94f780c03b4eee9d1a3b5b3f5e28a47932e39c89a3459ed14c068aebd58b0fa935c4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
