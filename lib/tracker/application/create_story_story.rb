require 'interactor'

module Tracker
  module Application
    class CreateStoryStory
      include Interactor

      def perform
        story_story_attributes = {
          parent_story_id: context[:parent_story_id],
          child_story_id: context[:child_story_id]
        }

        if Tracker.pg[:story_stories].where(story_story_attributes).any?
          fail!(message: :already_exists)
        else
          story_story_id = Tracker.pg[:story_stories].insert(story_story_attributes)
          context[:story_story_id] = story_story_id
        end
      end
    end
  end
end