require 'interactor'

module Tracker
  module Application
    class LoadStory
      include Interactor

      def perform
        story_id = context[:story_id]

        story = Tracker.pg[:stories][id: story_id]

        context[:story] = story
      end
    end
  end
end