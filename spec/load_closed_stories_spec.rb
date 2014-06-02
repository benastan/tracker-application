require 'spec_helper'

module Tracker
  module Application
    describe LoadClosedStories do
      let!(:closed_story_id){Tracker.pg[:stories].insert(title: 'Closed story', closed_at: closed_at)}
      let(:closed_at){Time.new}

      before do
        Tracker.pg[:stories].insert(
          title: 'Started story',
          started_at: Time.new
        )

        Tracker.pg[:stories].insert(
          title: 'Finished story',
          started_at: Time.new,
          finished_at: Time.new
        )
      end

      subject(:result){LoadClosedStories.perform}

      it 'is successful' do
        expect(result).to be_success
      end

      it 'includes only the closed story' do
        expect(result.closed_stories.all).to eq [
          {
            id: closed_story_id,
            title: 'Closed story',
            started_at: nil,
            finished_at: nil,
            closed_at: closed_at
          }
        ]
      end
    end
  end
end