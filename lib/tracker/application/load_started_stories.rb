require 'interactor'

module Tracker
  module Application
    class LoadStartedStories
      include Interactor

      def perform
        started_stories = Tracker.pg[:stories].where(where_sql_statement)

        context[:started_stories] = started_stories
      end

      private

      def where_sql_statement
        'started_at IS NOT NULL AND finished_at IS NULL AND closed_at IS NULL'
      end
    end
  end
end