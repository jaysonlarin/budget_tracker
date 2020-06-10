require 'rails_helper'

RSpec.describe Entry, type: :model do

  it { should belong_to(:category) }

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:activity_date) }
    it { should validate_presence_of(:expense) }
  end

  describe '.for_today' do
    before do
      2.times do
        Category.create(name: Faker::Appliance.brand)
      end

      5.times do
        Entry.create!(
          amount: Faker::Number.decimal(l_digits: 2),
          activity_date: Faker::Date.between(from: 7.days.ago, to: 1.days.ago),
          expense: Faker::Number.within(range: 0..1),
          notes: Faker::Quotes::Shakespeare.king_richard_iii_quote,
          category: Category.first
        )
      end

      5.times do
        Entry.create!(
          amount: Faker::Number.decimal(l_digits: 2),
          activity_date: Date.today,
          expense: Faker::Number.within(range: 0..1),
          notes: Faker::Quotes::Shakespeare.king_richard_iii_quote,
          category: Category.last
        )
      end
    end

    it 'displays entries for a day' do
      expect(Entry.all.size).to eq 10
      expect(Entry.for_today.size).to eq 5
    end
  end
end
