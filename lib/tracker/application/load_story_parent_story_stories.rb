require 'interactor'

module Tracker
  module Application
    class LoadStoryParentStoryStories
      include Interactor

      def perform
        story_id = context[:story_id]

        parent_story_stories = Tracker.pg[:story_stories]
          .where(child_story_id: story_id)
          .join(:stories, id: :parent_story_id)
          .select(
            :story_stories__id,
            :story_stories__parent_story_id,
            :story_stories__child_story_id,
            :stories__title___parent_story_title
          )

        context[:parent_story_stories] = parent_story_stories
      end
    end
  end
end