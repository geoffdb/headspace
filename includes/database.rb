# ========
# Database
# ========

# This file loads and configures the database

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.colorize_logging = false

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :dbfile  => "./data/db.sqlite"
)

require_all "data/schema"
require_all "data/models"