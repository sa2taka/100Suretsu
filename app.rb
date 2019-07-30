require 'rubygems'
require 'sinatra/base'

class Suretsu < Sinatra::Base
  get '/' do
    'Hello, Sinatra'
  end
end
