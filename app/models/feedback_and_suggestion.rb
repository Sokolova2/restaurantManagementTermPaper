class FeedbackAndSuggestion < ApplicationRecord
  belongs_to :client, dependent: :destroy, optional: true
end
