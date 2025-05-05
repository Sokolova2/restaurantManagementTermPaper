class FeedbacksAndSuggestionsController < ApplicationController
  def index
    @feedback_and_suggestion = FeedbackAndSuggestion.new
  end

  def create
    @feedback_and_suggestion = FeedbackAndSuggestion.new(feedback_params)

    client = Client.find_by(phone_number: @feedback_and_suggestion.phone_number)
    @feedback_and_suggestion.client = client

    if @feedback_and_suggestion.save
      redirect_to feedbacks_and_suggestions_path
      flash[:notice] = "Відгук надіслано"
    else
      render :index
    end
  end

  private

  def feedback_params
    params.require(:feedback_and_suggestion).permit(:feedback, :phone_number)
  end
end
