require 'spec_helper'

module Tracker
  module Application
    describe CreateStory do
      subject(:result) { CreateStory.perform(title: 'My title') }

      it 'creates a story' do
        expect(->{subject}).to change{Tracker.pg[:stories].count}.by(1)
        expect(result.story_id).to eq Tracker.pg[:stories].where(title: 'My title').first[:id]
      end
    end
  end
end