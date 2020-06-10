require 'rails_helper'

RSpec.describe "/entries", type: :request do
  before do
    Category.create!(name: Faker::Appliance.brand)
  end

  let!(:category) { Category.first }

  let(:valid_attributes) {
    {
      amount: Faker::Number.decimal(l_digits: 2),
      activity_date: Faker::Date.between(from: 7.days.ago, to: 1.days.ago),
      expense: Faker::Number.within(range: 0..1),
      notes: Faker::Quotes::Shakespeare.king_richard_iii_quote,
      category_id: Category.first.id
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Entry.create! valid_attributes
      get entries_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      entry = Entry.create! valid_attributes
      get entry_url(entry)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_entry_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      entry = Entry.create! valid_attributes
      get edit_entry_url(entry)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Entry" do

        expect {
          post entries_url, params: { entry: valid_attributes }
        }.to change(Entry, :count).by(1)
      end

      it "redirects to the created entry" do
        post entries_url, params: { entry: valid_attributes }
        expect(response).to redirect_to(entry_url(Entry.last))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { notes: "The king's name is a tower of strength." }
      }

      it "updates the requested entry" do
        entry = Entry.create! valid_attributes
        patch entry_url(entry), params: { entry: new_attributes }
        entry.reload

        expect(entry.notes).to eq "The king's name is a tower of strength."
      end

      it "redirects to the entry" do
        entry = Entry.create! valid_attributes
        patch entry_url(entry), params: { entry: new_attributes }
        entry.reload
        expect(response).to redirect_to(entry_url(entry))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested entry" do
      entry = Entry.create! valid_attributes
      expect {
        delete category_url(category)
      }.to change(Entry, :count).by(0)
    end

    it "redirects to the entries list" do
      entry = Entry.create! valid_attributes
      delete entry_url(entry)
      expect(response).to redirect_to(entries_url)
    end
  end
end
