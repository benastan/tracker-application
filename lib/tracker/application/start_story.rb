require 'interactor'

module Tracker
  module Application
    class StartStory
      include Interactor

      def perform
        story_id = context[:story_id]

        Tracker.pg[:stories].where(id: story_id).update(started_at: Sequel::CURRENT_TIMESTAMP)
      end
    end
  end
end
