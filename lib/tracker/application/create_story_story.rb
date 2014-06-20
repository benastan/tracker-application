require 'interactor'

module Tracker
  module Application
    class CreateStoryStory
      include Interactor

      def perform
        child_story_id = context[:child_story_id]
        parent_story_id = context[:parent_story_id]

        story_story_attributes = {
          parent_story_id: parent_story_id,
          child_story_id: child_story_id
        }

        recursive_sql = Tracker::PG.recursive_parent_story_stories_sql(parent_story_id)

        invalid_story_stories = Tracker.pg[:story_stories].where("id in (#{recursive_sql})").where(
          parent_story_id: child_story_id
        )

        if Tracker.pg[:story_stories].where(story_story_attributes).any?
          fail!(message: :already_exists)
        else
          invalid_story_stories.delete
          story_story_id = Tracker.pg[:story_stories].insert(story_story_attributes)
          context[:story_story_id] = story_story_id
        end
      end
    end
  end
end