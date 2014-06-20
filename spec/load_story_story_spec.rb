require 'spec_helper'

module Tracker
  module Application
    describe LoadStoryStory do
      let(:parent_story_id) { Tracker.pg[:stories].insert(title: 'Parent Story') }
      let(:child_story_id) { Tracker.pg[:stories].insert(title: 'Child Story') }

      subject(:result) do
        LoadStoryStory.perform(
          parent_story_id: parent_story_id,
          child_story_id: child_story_id
        )
      end

      context 'when the story story does not exist' do
        it 'is empty and does not blow up' do
          expect(result.story_story).to be_nil
        end
      end

      context 'when the story story exists' do
        let!(:story_story_id) do
          Tracker.pg[:story_stories].insert(
            parent_story_id: parent_story_id,
            child_story_id: child_story_id
          )
        end

        it 'loads the story story' do
          expect(result.story_story).to eq(
            id: story_story_id,
            parent_story_id: parent_story_id,
            child_story_id: child_story_id
          )
        end
      end
    end
  end
end