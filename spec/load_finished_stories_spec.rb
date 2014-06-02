require 'spec_helper'

module Tracker
  module Application
    describe LoadFinishedStories do
      let!(:finished_story_id){Tracker.pg[:stories].insert(title: 'Finished story', finished_at: finished_at)}
      let(:finished_at){Time.new}

      before do
        Tracker.pg[:stories].insert(
          title: 'Started story',
          started_at: Time.new
        )

        Tracker.pg[:stories].insert(
          title: 'Closed story',
          started_at: Time.new,
          finished_at: Time.new,
          closed_at: Time.new
        )
      end

      subject(:result){LoadFinishedStories.perform}

      it 'is successful' do
        expect(result).to be_success
      end

      it 'includes only the finished story' do
        expect(result.finished_stories.all).to eq [
          {
            id: finished_story_id,
            title: 'Finished story',
            started_at: nil,
            finished_at: finished_at,
            closed_at: nil
          }
        ]
      end
    end
  end
end