require 'spec_helper'

module Tracker
  module Application
    describe CloseStory do
      let!(:story_id) { Tracker.pg[:stories].insert(title: 'Story to Close') }
      subject { CloseStory.perform(story_id: story_id) }

      def story_closed_at
        Tracker.pg[:stories][id: story_id][:closed_at]
      end
      
      specify { expect(->{subject}).to change{story_closed_at}.from(nil) }
    end
  end
end
