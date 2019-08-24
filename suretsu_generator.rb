class SuretsuGenerator
  def initialize(ratio, first)
    @ratio = ratio
    @first = first
  end

  def generate(index = 0, count = 10)
    (index..(index + count - 1)).map do |i|
      @first * @ratio ** i
    end
  end
end
