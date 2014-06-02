require 'spec_helper'

module Tracker
  module Application
    describe LoadEpicStories do
      let(:unblocked_story_id){Tracker.pg[:stories].insert(title: 'Unblocked story')}
      let(:blocked_story_id){Tracker.pg[:stories].insert(title: 'Blocked story')}
      let(:epic_story_id){Tracker.pg[:stories].insert(title: 'Epic story')}

      before do
        CreateStoryStory.perform(
          parent_story_id: blocked_story_id,
          child_story_id: unblocked_story_id
        )

        CreateStoryStory.perform(
          parent_story_id: epic_story_id,
          child_story_id: blocked_story_id
        )
      end

      subject(:result) { LoadEpicStories.perform }

      it 'is successful' do
        expect(result).to be_success
      end

      it 'includes only the epic story' do
        expect(result.epic_stories.all).to eq [
          {
            id: epic_story_id,
            title: 'Epic story',
            started_at: nil,
            finished_at: nil,
            closed_at: nil
          }
        ]
      end
    end
  end
end
