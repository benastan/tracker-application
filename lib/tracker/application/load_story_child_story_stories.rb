require 'interactor'

module Tracker
  module Application
    class LoadStoryChildStoryStories
      include Interactor

      def perform
        story_id = context[:story_id]

        child_story_stories = Tracker.pg[:story_stories]
          .where(parent_story_id: story_id)
          .join(:stories, id: :child_story_id)
          .select(
            :story_stories__id,
            :story_stories__parent_story_id,
            :story_stories__child_story_id,
            :stories__title___child_story_title
          )

        context[:child_story_stories] = child_story_stories
      end
    end
  end
end