class Client < ApplicationRecord
  has_one :feedback_and_suggestion
  has_one :table
end
