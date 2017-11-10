# TODO: this is wrong - we need to fetch current envronment, not hardcode it.
ENV['RACK_ENV'] ||= 'development'
ENV['DATABASE_URL']="sqlite://bs_#{ENV['RACK_ENV']}.sqlite3"
DB = Sequel.connect(ENV['DATABASE_URL'])
