require 'interactor'

module Tracker
  module Application
    class ResetStory
      include Interactor::Organizer

      organize [
        UnstartStory,
        UnfinishStory,
        UncloseStory
      ]
    end
  end
end
