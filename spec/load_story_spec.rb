require 'spec_helper'

module Tracker
  module Application
    describe LoadStory do
      let(:story_id){CreateStory.perform(title: 'My Story').story_id}
      subject(:result){LoadStory.perform(story_id: story_id)}

      it 'creates a story' do
        expect(result.story).to eq(id: story_id, title: 'My Story', started_at: nil, finished_at: nil, closed_at: nil)
      end
    end
  end
end