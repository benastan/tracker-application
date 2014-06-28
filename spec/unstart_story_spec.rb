require 'spec_helper'

module Tracker
  module Application
    describe UnstartStory do
      let!(:story_id) do
        Tracker.pg[:stories].insert(
          title: 'Story to Start',
          started_at: Sequel::CURRENT_TIMESTAMP
        )
      end
      
      subject { UnstartStory.perform(story_id: story_id) }

      def story_started_at
        Tracker.pg[:stories][id: story_id][:started_at]
      end

      specify { expect(->{subject}).to change{story_started_at}.to(nil) }
    end
  end
end
