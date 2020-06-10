class PrintsController < ApplicationController

  def index
    @entries = Entry.for_today
  end

  def trigger
    SummaryJob.perform_now
  end
end