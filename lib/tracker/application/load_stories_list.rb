require 'interactor'

module Tracker
  module Application
    class LoadStoriesList
      include Interactor::Organizer

      organize [
        LoadBlockedStories,
        LoadClosedStories,
        LoadEpicStories,
        LoadFinishedStories,
        LoadStartedStories,
        LoadUnblockedStories
      ]
    end
  end
end