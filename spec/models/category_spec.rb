require 'rails_helper'

RSpec.describe Category, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe '.active' do
    before do
      3.times do
        Category.create(name: Faker::App.name)
      end

      2.times do
        Category.create(name: Faker::App.name, active: false)
      end
    end

    it 'returns not removed categories' do
      expect(Category.all.size).to eq 5
      expect(Category.active.size).to eq 3
    end
  end

end
