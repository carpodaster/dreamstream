require 'sinatra'
require 'sinatra/reloader'

get '/' do
  'Hello Sinatra'
end

get '/export' do
  stream do |out|
    1.upto(10) do
      out << "Hello world\n"
      sleep 1
    end
    out.flush
  end
end
