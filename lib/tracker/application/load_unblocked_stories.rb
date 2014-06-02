require 'interactor'

module Tracker
  module Application
    class LoadUnblockedStories
      include Interactor

      def perform
        unblocked_stories = Tracker.pg[:stories].where(where_sql_statement)

        context[:unblocked_stories] = unblocked_stories
      end
      
      private

      def where_sql_statement
        '(select count(id) from story_stories where story_stories.parent_story_id = stories.id) = 0'
      end
    end
  end
end