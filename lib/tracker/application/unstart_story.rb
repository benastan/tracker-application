require 'interactor'

module Tracker
  module Application
    class UnstartStory
      include Interactor

      def perform
        story_id = context[:story_id]

        Tracker.pg[:stories].where(id: story_id).update(started_at: nil)
      end
    end
  end
end
