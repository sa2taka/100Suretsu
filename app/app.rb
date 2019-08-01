require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require "sinatra/cookies"

require './suretsu_generator.rb'
require './lucas_number.rb'

LUCA = LucasNumber.new

class Suretsu < Sinatra::Base
  helpers Sinatra::Cookies
  enable :sessions

  get '/' do
    erb :top
  end

  get '/:index' do
    pass if params[:a].nil? || params[:r].nil?
    pass unless LUCA.index(params[:index].to_i) == 99 && params[:a] == cookies[:a] && params[:r] == cookies[:r] 
    'congraturate'
  end

  get '/:index' do
    @now = LUCA.index(params[:index].to_i)

    pass unless @now
    pass if @now != 0 && (params[:a].nil? || params[:r].nil?)
    pass unless (params[:a].to_i == cookies[:a].to_i && params[:r].to_i == cookies[:r].to_i) || @now == 0
    @next = LUCA[@now + 1]
    @seq, a, r = generate_new_suretsu
    cookies[:a] = a
    cookies[:r] = r
    erb :quiz
  end

  get '/:index' do
    pass unless LUCA.index(params[:index].to_i)
    @message = '不正解です'
    erb :error
  end

  get '/:index' do
    @message = '不正なページ遷移です'
    erb :error
  end

  private 
  def generate_new_suretsu
    a = Random.rand(1..50)
    r = 0
    loop do
      r = Random.rand(3..10)
      break if a % r != 0
    end
    suretsu = SuretsuGenerator.new(r, a)
    [suretsu.generate(3, 5), a, r]
  end
end
