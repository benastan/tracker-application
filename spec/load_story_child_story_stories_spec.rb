require 'spec_helper'

module Tracker
  module Application
    describe LoadStoryChildStoryStories do
      let(:unblocked_story_id){Tracker.pg[:stories].insert(title: 'Unblocked story')}
      let(:blocked_story_id){Tracker.pg[:stories].insert(title: 'Blocked story')}

      let!(:parent_story_story_id) do
        result = Tracker.pg[:story_stories].insert(
          parent_story_id: blocked_story_id,
          child_story_id: unblocked_story_id
        )
      end

      subject(:result) { LoadStoryChildStoryStories.perform(story_id: blocked_story_id) }

      it 'is successful' do
        expect(result).to be_success
      end

      it 'includes the only the parent story' do
        expect(result.child_story_stories.all).to eq [
          {
            id: parent_story_story_id,
            parent_story_id: blocked_story_id,
            child_story_id: unblocked_story_id,
            child_story_title: 'Unblocked story'
          }
        ]
      end
    end
  end
end
