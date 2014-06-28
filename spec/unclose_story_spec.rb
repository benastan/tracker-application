require 'spec_helper'

module Tracker
  module Application
    describe UncloseStory do
      let!(:story_id) do
        Tracker.pg[:stories].insert(
          title: 'Story to Start',
          closed_at: Sequel::CURRENT_TIMESTAMP
        )
      end

      subject { UncloseStory.perform(story_id: story_id) }

      def story_closed_at
        Tracker.pg[:stories][id: story_id][:closed_at]
      end

      specify { expect(->{subject}).to change{story_closed_at}.to(nil) }
    end
  end
end
