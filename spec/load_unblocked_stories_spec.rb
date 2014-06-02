require 'spec_helper'

module Tracker
  module Application
    describe LoadUnblockedStories do
      let(:unblocked_story_id){Tracker.pg[:stories].insert(title: 'Unblocked story')}
      let(:blocked_story_id){Tracker.pg[:stories].insert(title: 'Blocked story')}

      before do
        CreateStoryStory.perform(
          parent_story_id: blocked_story_id,
          child_story_id: unblocked_story_id
        )
      end

      subject(:result) { LoadUnblockedStories.perform }

      it 'is successful' do
        expect(result).to be_success
      end

      it 'includes the unblocked story and not the blocked story' do
        expect(result.unblocked_stories.all).to eq [
          {
            id: unblocked_story_id,
            title: 'Unblocked story',
            started_at: nil,
            finished_at: nil,
            closed_at: nil
          }
        ]
      end
    end
  end
end
