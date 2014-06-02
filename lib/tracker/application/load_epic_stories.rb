require 'interactor'

module Tracker
  module Application
    class LoadEpicStories
      include Interactor

      def perform
        epic_stories = Tracker.pg[:stories].where(where_sql_statement)

        context[:epic_stories] = epic_stories
      end
      
      private

      def where_sql_statement
        '%s AND %s' % [
          '(SELECT COUNT(id) FROM story_stories WHERE story_stories.parent_story_id = stories.id) > 0',
          '(SELECT COUNT(id) FROM story_stories WHERE story_stories.child_story_id = stories.id) = 0'
        ]
      end
    end
  end
end