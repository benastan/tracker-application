require 'spec_helper'

module Tracker
  module Application
    describe FinishStory do
      let!(:story_id) { Tracker.pg[:stories].insert(title: 'Story to Finish') }
      subject { FinishStory.perform(story_id: story_id) }

      def story_finished_at
        Tracker.pg[:stories][id: story_id][:finished_at]
      end
      
      specify { expect(->{subject}).to change{story_finished_at}.from(nil) }
    end
  end
end
