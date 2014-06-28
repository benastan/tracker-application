require 'spec_helper'

module Tracker
  module Application
    describe StartStory do
      let!(:story_id) { Tracker.pg[:stories].insert(title: 'Story to Start') }
      subject { StartStory.perform(story_id: story_id) }

      def story_started_at
        Tracker.pg[:stories][id: story_id][:started_at]
      end
      
      specify { expect(->{subject}).to change{story_started_at}.from(nil) }
    end
  end
end
