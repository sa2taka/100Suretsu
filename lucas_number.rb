class LucasNumber
  attr_reader :lucas_numbers
  def initialize(count = 200) 
    @lucas_numbers = [2, 1]
    generate(count)
  end

  def [](n)
    @lucas_numbers[n]
  end

  def index(n)
    @lucas_numbers.index(n)
  end

  private 

  def generate(count)
    (2..count).each do |i|
      @lucas_numbers[i] = @lucas_numbers[i - 1] + @lucas_numbers[i - 2]
    end
  end
end
