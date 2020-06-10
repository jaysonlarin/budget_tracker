require 'rails_helper'

RSpec.describe SummaryJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later }

  it 'queues the job' do
    expect { job }.to change(ApplicationJob.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in default queue' do
    expect(SummaryJob.new.queue_name).to eq('default')
  end
end
