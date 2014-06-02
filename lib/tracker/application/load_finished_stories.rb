require 'interactor'

module Tracker
  module Application
    class LoadFinishedStories
      include Interactor

      def perform
        finished_stories = Tracker.pg[:stories].where(where_sql_statement)

        context[:finished_stories] = finished_stories
      end

      private

      def where_sql_statement
        'finished_at IS NOT NULL AND closed_at IS NULL'
      end
    end
  end
end