require 'rubygems'
require 'sinatra/base'
require './suretsu_generator.rb'
require './lucas_number.rb'

LUCA = LucasNumber.new

class Suretsu < Sinatra::Base
  get '/' do
    'Hello, Sinatra'
  end

  get '/:index' do
    if LUCA.index(params[:index].to_i) == 99
      'congraturate'
    elsif (@now = LUCA.index(params[:index].to_i))
      @next = LUCA[@now + 1]
      @seq, a, r = generate_new_suretsu
      @seq.to_s + " = #{a} * #{r}^n"
    else
      'husei'
    end
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
