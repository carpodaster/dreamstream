require 'sinatra'
require 'sinatra/reloader'

get '/' do
  'Hello Sinatra'
end

SleepyRecord = Struct.new(:items_count) do
  class << self
    def find_in_batches
      1.upto(4).map { new(10) }
    end
  end

  def each
    items_count.times do
      sleep 0.3
      yield "My;CSV;line\n"
    end
  end
end

get '/export' do
  stream do |out|
    SleepyRecord.new(10).each do |line|
      out << line
    end
    out.flush
  end
end
