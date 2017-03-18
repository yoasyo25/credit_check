require 'pry'

class CreditCheck

  attr_reader :original_number

  def initialize(original_number)
    @original_number = original_number
  end

  def format_original_number
    @original_number.to_s.split("").map { |num| num.to_i }
  end

  def check_digit
    format_original_number.pop
  end

  def exclude_check_digit
    format_original_number.reject.with_index { |num, index| index == 15 }
  end

  def double_index
    exclude_check_digit.map.with_index do |num, index|
      index.even? ? num * 2 : num
    end
  end

  def sum_index
    double_index.map.with_index do |num, index|
      index.even? && num > 9 ? num.to_s.split("").map { |num| num.to_i }.inject(:+) : num
    end
  end

  def insert_check_digit
    sum_index.push(check_digit)
  end

  def check_modulo
    insert_check_digit.inject(:+) % 10 == 0 ? "The number is valid!" : "The number is invalid!"
  end

end
