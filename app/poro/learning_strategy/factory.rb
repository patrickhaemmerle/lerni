class LearningStrategy::Factory
    def self.createLearningStrategy box_id
        return LearningStrategy::Leitner.new
    end
end