require 'spec_helper'

module Tracker
  module Application
    describe ResetStory do
      before do
        allow(UnstartStory).to receive(:perform).and_return(double(success?: true))
        allow(UnfinishStory).to receive(:perform).and_return(double(success?: true))
        allow(UncloseStory).to receive(:perform).and_return(double(success?: true))
      end

      subject { ResetStory.perform({}) }

      specify do
        subject
        expect(UnstartStory).to have_received(:perform)
      end

      specify do
        subject
        expect(UnfinishStory).to have_received(:perform)
      end

      specify do
        subject
        expect(UncloseStory).to have_received(:perform)
      end
    end
  end
end