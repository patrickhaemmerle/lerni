class Card < ActiveRecord::Base
  belongs_to :box
  has_one :learning_strategy_leitner_card_info, dependent: :destroy
end
