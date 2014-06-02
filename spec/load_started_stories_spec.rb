require 'spec_helper'

module Tracker
  module Application
    describe LoadStartedStories do
      let!(:started_story_id){Tracker.pg[:stories].insert(title: 'Started story', started_at: started_at)}
      let(:started_at){Time.new}
      
      before do
        Tracker.pg[:stories].insert(
          title: 'Finished story',
          started_at: started_at,
          finished_at: Time.new
        )

        Tracker.pg[:stories].insert(
          title: 'Closed story',
          started_at: started_at,
          finished_at: Time.new,
          closed_at: Time.new
        )
      end

      subject(:result){LoadStartedStories.perform}

      it 'is successful' do
        expect(result).to be_success
      end

      it 'includes only the started story' do
        expect(result.started_stories.all).to eq [
          {
            id: started_story_id,
            title: 'Started story',
            started_at: started_at,
            finished_at: nil,
            closed_at: nil
          }
        ]
      end
    end
  end
end