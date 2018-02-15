require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/streaming'
require 'thread'

require_relative './sleepy_record'

get '/' do
  'Hello Sinatra'
end

get '/export' do
  @queue = Queue.new
  SleepyRecord.find_in_batches { |batch| @queue << batch }

  readio, writeio = IO.pipe

  @threads = 1.upto(3).map do
    Thread.new {
      until @queue.empty? do
        group = @queue.pop
        group.each { |line| writeio.write line }
      end
    }
  end

  stream do |out|
    while chunk = readio.gets do
      out << chunk
      out.flush
    end
  end
end
