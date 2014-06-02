require 'interactor'

module Tracker
  module Application
    class LoadClosedStories
      include Interactor

      def perform
        closed_stories = Tracker.pg[:stories].where('closed_at IS NOT NULL')

        context[:closed_stories] = closed_stories
      end
    end
  end
end