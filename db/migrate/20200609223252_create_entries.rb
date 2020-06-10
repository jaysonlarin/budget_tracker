class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.references :category, null: false, foreign_key: true
      t.date :activity_date
      t.decimal :amount
      t.string :notes
      t.integer :expense, default: 1

      t.timestamps
    end
  end
end
