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

  stream do |out|
    until @queue.empty? do
      group = @queue.pop
      group.each { |line| out << line }
    end
    out.flush
  end
end
