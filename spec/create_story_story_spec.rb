require 'spec_helper'

module Tracker
  module Application
    describe CreateStoryStory do
      let(:parent_story_id) { Tracker.pg[:stories].insert(title: 'Parent story') }
      let(:child_story_id) { Tracker.pg[:stories].insert(title: 'Child story') }

      subject(:result) do
        CreateStoryStory.perform(
          parent_story_id: parent_story_id,
          child_story_id: child_story_id
        )
      end
      
      let(:new_story_story) do
        Tracker.pg[:story_stories].first(
          parent_story_id: parent_story_id,
          child_story_id: child_story_id
        )
      end

      it 'creates a story story' do
        expect(->{subject}).to change{Tracker.pg[:story_stories].count}.by(1)
      end

      it 'is successful' do
        expect(result).to be_success
      end

      it 'includes the id of the new story story in the result' do
        expect(result.story_story_id).to eq new_story_story[:id]
      end

      context 'when the story story already exists' do
        before do
         attributes = {
            parent_story_id: parent_story_id,
            child_story_id: child_story_id
          }

          Tracker.pg[:story_stories].insert(attributes)
        end
        
        it 'does not create a story story' do
          expect(->{subject}).not_to change{Tracker.pg[:story_stories].count}
        end

        it 'includes a message in the result' do
          expect(result.message).to eq :already_exists
        end

        it 'is not successful' do
          expect(result).not_to be_success
        end
      end

      context 'when the child story is the parent story of a story that is the parent to the parent story' do
        let!(:parent_parent_story_id) do
          Tracker.pg[:stories].insert(title: 'Parent story story')
        end

        let!(:parent_parent_story_story_id) do
          Tracker.pg[:story_stories].insert(
            child_story_id: parent_story_id,
            parent_story_id: parent_parent_story_id
          )
        end

        let!(:parent_parent_parent_story_id) do
          Tracker.pg[:story_stories].insert(
            child_story_id: parent_parent_story_id,
            parent_story_id: child_story_id
          )
        end

        it 'deletes parent_parent_parent_story_id' do
          expect(->{subject}).to change{Tracker.pg[:story_stories][id: parent_parent_parent_story_id]}.from(
            id: parent_parent_parent_story_id,
            child_story_id: parent_parent_story_id,
            parent_story_id: child_story_id
          ).to(nil)
        end
      end
    end
  end
end
