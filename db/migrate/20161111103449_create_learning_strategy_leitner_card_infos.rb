class CreateLearningStrategyLeitnerCardInfos < ActiveRecord::Migration
  def change
    create_table :learning_strategy_leitner_card_infos do |t|
      t.integer :compartment
      t.datetime :last_seen
      t.references :card, index: true, foreign_key: {on_delete: :cascade}, null: false

      t.timestamps null: false
    end
  end
end
