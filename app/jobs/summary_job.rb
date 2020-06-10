class SummaryJob < ApplicationJob
  queue_as :default

  def perform(date=Date.today)
    Rails.logger.info("+++ Entries for #{date} +++")
    entries = Entry.for_today(date)
    entries.map do |entry|
      Rails.logger.info "#{entry.activity_date} | #{entry.amount} | #{entry.category.name} | #{entry.notes}"
    end
    Rails.logger.info("+++ Entries for #{date} +++")
  end
end