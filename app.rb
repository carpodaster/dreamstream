require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/streaming'
require 'thread'

require_relative './sleepy_record'

WORKERS = 3

use Rack::Logger

helpers do
  def log(chunk)
    request.logger.info chunk.chomp
  end
end

get '/export/sequentially' do
  content_type "text/csv"
  attachment "export_seq.csv"

  stream do |out|
    SleepyRecord.all.each do |csv|
      log csv
      out << csv
      out.flush
    end
  end
end

get '/export/parallel' do
  @queue = SizedQueue.new(WORKERS * 2)

  # Separate thread since push op on SizedQueue may block
  Thread.new { SleepyRecord.find_in_batches { |batch| @queue << batch } }

  readio, writeio = IO.pipe

  @exporters = 1.upto(3).map do
    Thread.new {
      until @queue.empty? do
        group = @queue.pop
        group.each { |line| writeio.write line }
      end
    }
  end

  # IO "guard"
  Thread.new {
    while @exporters.any?(&:alive?) do sleep 0.01 end
    writeio.close
  }

  content_type "text/csv"
  attachment "export_par.csv"

  stream do |out|
    while chunk = readio.gets do
      log chunk
      out << chunk
      out.flush
    end
  end
end
