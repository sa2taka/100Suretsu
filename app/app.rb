require 'rubygems'
require 'sinatra/base'
require './suretsu_generator.rb'
require './lucas_number.rb'

LUCA = LucasNumber.new

class Suretsu < Sinatra::Base
  enable :sessions

  get '/' do
    'Hello, Sinatra'
  end

  get '/:index' do
    pass unless LUCA.index(params[:index].to_i) == 99 && params[:a] == session[:a] && params[:r] == session[:r] 
    'congraturate'
  end

  get '/:index' do
    @now = LUCA.index(params[:index].to_i)

    pass unless @now
    pass if @now != 0 && (params[:a].nil? || params[:r].nil?)
    pass unless (params[:a].to_i == session[:a].to_i && params[:r].to_i == session[:r].to_i) || @now == 0
    
    @next = LUCA[@now + 1]
    @seq, a, r = generate_new_suretsu
    session[:a] = a
    session[:r] = r
    @seq.to_s + " = #{a} * #{r}^n"
  end

  get '/:index' do
    pass unless (LUCA.index(params[:index].to_i))
    '不正解です'
  end

  get '/:index' do
    '不正なページ遷移です'
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
