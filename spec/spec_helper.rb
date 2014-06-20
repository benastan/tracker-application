require 'bundler'
Bundler.require
require 'tracker/p_g'
require 'tracker/application'

ENV['TEST_DATABASE_URL'] ||= 'postgres://postgres@localhost:5432/new_tracker_test'

Tracker::PG.database_url = ENV['TEST_DATABASE_URL']

RSpec.configure do |config|
  config.around(:each) do |example|
    Tracker.pg.transaction(rollback: :always) do
      example.run
    end
  end
end