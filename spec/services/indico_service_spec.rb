require 'rails_helper'

RSpec.describe SlackService do
  describe "Indico sentiment analysis" do
    it "grades negative messages with low scores" do
      VCR.use_cassette 'negative_message_scores' do
        negative_messages = ["I hate you",
                             "My project is so bad",
                             "This is the dumbest thing ever"]

        Indico.api_key = ENV['INDICO_KEY']
        sentiments = Indico.sentiment(negative_messages)

        sentiments.each do |score|
          expect(score).to be < 0.2
        end
      end
    end

    it "grades positive messages with high scores" do
      VCR.use_cassette 'positive_message_scores' do
        positive_messages = ["I love you",
                             "My project is so great",
                             "This is the best thing ever"]

        Indico.api_key = ENV['INDICO_KEY']
        sentiments = Indico.sentiment(positive_messages)

        sentiments.each do |score|
          expect(score).to be > 0.8
        end
      end
    end

    it "grades neutral messages with average scores" do
      VCR.use_cassette 'neutral_message_scores' do
        neutral_messages = ["These are apples",
                            "Class is helpful but a little boring sometimes",
                            "I dont have any balloons today"]

        Indico.api_key = ENV['INDICO_KEY']
        sentiments = Indico.sentiment(neutral_messages)

        sentiments.each do |score|
          expect(score).to be > 0.3
          expect(score).to be < 0.7
        end
      end
    end
  end
end
