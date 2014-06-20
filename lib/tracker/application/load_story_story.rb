require 'interactor'

module Tracker
  module Application
    class LoadStoryStory
      include Interactor

      def perform
        parent_story_id = context[:parent_story_id]
        child_story_id = context[:child_story_id]

        story_story = Tracker.pg[:story_stories][
          parent_story_id: parent_story_id,
          child_story_id: child_story_id
        ]

        context[:story_story] = story_story
      end
    end
  end
end