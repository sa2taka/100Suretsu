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

  # @nowが0のとき
  get '/:index' do
    @now = LUCA.index(params[:index].to_i)
    pass unless @now == 0
    
    session[:start_time] = Time.now
    @next = LUCA[@now + 1]
    @seq, a, r = generate_new_suretsu
    cookies[:a] = a
    cookies[:r] = r
    erb :quiz
  end

  # 時間切れの場合
  get '/:index' do
    st = session[:start_time]
    nt = Time.now

    pass if nt <= (st + 180)
    @message = '時間切れです。3分以内に解いてください'
    erb :error
  end

  # 不正なページ遷移時
  get '/:index' do
    pass if LUCA.index(params[:index].to_i)
    pass unless params[:a].nil? || params[:r].nil?

    @message = '不正なページ遷移です'
    erb :error
  end

  # 不正解の場合
  get '/:index' do
    pass if params[:a] == cookies[:a] && params[:r] == cookies[:r] 
    
    @message = '不正解です'
    erb :error
  end

  # 100問解いた場合
  get '/:index' do
    pass unless LUCA.index(params[:index].to_i) == 99
    erb :congraturate
  end

  get '/:index' do
    @now = LUCA.index(params[:index].to_i)
    @next = LUCA[@now + 1]
    @seq, a, r = generate_new_suretsu
    cookies[:a] = a
    cookies[:r] = r
    erb :quiz
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
