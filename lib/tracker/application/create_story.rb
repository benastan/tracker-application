require 'interactor'

module Tracker
  module Application
    class CreateStory
      include Interactor

      def perform
        title = context[:title]

        story_id = Tracker.pg[:stories].insert(title: title)

        context[:story_id] = story_id
      end
    end
  end
end