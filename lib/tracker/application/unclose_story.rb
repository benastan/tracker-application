require 'interactor'

module Tracker
  module Application
    class UncloseStory
      include Interactor

      def perform
        story_id = context[:story_id]

        Tracker.pg[:stories].where(id: story_id).update(closed_at: nil)
      end
    end
  end
end
