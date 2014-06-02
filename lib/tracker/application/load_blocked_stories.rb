require 'interactor'

module Tracker
  module Application
    class LoadBlockedStories
      include Interactor

      def perform
        blocked_stories = Tracker.pg[:stories].where(where_sql_statement)

        context[:blocked_stories] = blocked_stories
      end
      
      private
      
      def where_sql_statement
        '(select count(id) from story_stories where story_stories.parent_story_id = stories.id) > 0'
      end
    end
  end
end