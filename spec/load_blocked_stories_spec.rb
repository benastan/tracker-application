require 'spec_helper'

module Tracker
  module Application
    describe LoadBlockedStories do
      let(:unblocked_story_id){Tracker.pg[:stories].insert(title: 'Unblocked story')}
      let(:blocked_story_id){Tracker.pg[:stories].insert(title: 'Blocked story')}

      before do
        CreateStoryStory.perform(
          parent_story_id: blocked_story_id,
          child_story_id: unblocked_story_id
        )
      end

      subject(:result) { LoadBlockedStories.perform }

      it 'is successful' do
        expect(result).to be_success
      end

      it 'includes the blocked story and not the unblocked story' do
        expect(result.blocked_stories.all).to eq [{ id: blocked_story_id, title: 'Blocked story' }]
      end
    end
  end
end
