require 'spec_helper'

module Tracker
  module Application
    describe LoadStoriesList do
      before do
        allow(LoadBlockedStories).to receive(:perform).and_return(double(success?: true))
        allow(LoadClosedStories).to receive(:perform).and_return(double(success?: true))
        allow(LoadEpicStories).to receive(:perform).and_return(double(success?: true))
        allow(LoadFinishedStories).to receive(:perform).and_return(double(success?: true))
        allow(LoadStartedStories).to receive(:perform).and_return(double(success?: true))
        allow(LoadUnblockedStories).to receive(:perform).and_return(double(success?: true))
      end

      subject { LoadStoriesList.perform({}) }

      specify { expect(subject).to be_success }

      specify do
        subject
        expect(LoadBlockedStories).to have_received(:perform)
      end

      specify do
        subject
        expect(LoadClosedStories).to have_received(:perform)
      end

      specify do
        subject
        expect(LoadEpicStories).to have_received(:perform)
      end

      specify do
        subject
        expect(LoadFinishedStories).to have_received(:perform)
      end

      specify do
        subject
        expect(LoadStartedStories).to have_received(:perform)
      end

      specify do
        subject
        expect(LoadUnblockedStories).to have_received(:perform)
      end
    end
  end
end
