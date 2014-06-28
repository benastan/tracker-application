require 'spec_helper'

module Tracker
  module Application
    describe UnfinishStory do
      let!(:story_id) do
        Tracker.pg[:stories].insert(
          title: 'Story to Start',
          finished_at: Sequel::CURRENT_TIMESTAMP
        )
      end

      subject { UnfinishStory.perform(story_id: story_id) }

      def story_finished_at
        Tracker.pg[:stories][id: story_id][:finished_at]
      end

      specify { expect(->{subject}).to change{story_finished_at}.to(nil) }
    end
  end
end
