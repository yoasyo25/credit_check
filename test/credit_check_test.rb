require 'minitest/autorun'
require 'minitest/pride'
require './lib/credit_check'
require 'pry'

class CreditCheckTest < Minitest::Test

  def test_it_exists
    credit_check = CreditCheck.new("original_number")
    assert_instance_of CreditCheck, credit_check
  end

  def test_it_can_accept_user_input
    credit_check = CreditCheck.new(6011797668867828)
    assert_equal 6011797668867828, credit_check.original_number
  end

  def test_it_can_format_original_number_into_an_array
    credit_check = CreditCheck.new(6011797668867828)
    assert_equal [6, 0, 1, 1, 7, 9, 7, 6, 6, 8, 8, 6, 7, 8, 2, 8], credit_check.format_original_number
  end

  def test_it_can_grab_the_check_digit_number
    credit_check = CreditCheck.new(6011797668867828)
    assert_equal 8, credit_check.check_digit
  end

  def test_it_can_create_an_array_without_the_check_digit_number
    credit_check = CreditCheck.new(6011797668867828)
    assert_equal [6, 0, 1, 1, 7, 9, 7, 6, 6, 8, 8, 6, 7, 8, 2], credit_check.exclude_check_digit
  end

  def test_it_can_double_the_digits_with_even_index
    credit_check = CreditCheck.new(6011797668867828)
    assert_equal [12, 0, 2, 1, 14, 9, 14, 6, 12, 8, 16, 6, 14, 8, 4], credit_check.double_index
  end

  def test_it_can_sum_digits_that_are_greater_than_nine
    credit_check = CreditCheck.new(6011797668867828)
    assert_equal [3, 0, 2, 1, 5, 9, 5, 6, 3, 8, 7, 6, 5, 8, 4], credit_check.sum_index
  end

  def test_it_can_insert_the_check_digit_into_the_array_with_sum_index
    credit_check = CreditCheck.new(6011797668867828)
    assert_equal [3, 0, 2, 1, 5, 9, 5, 6, 3, 8, 7, 6, 5, 8, 4, 8], credit_check.insert_check_digit
  end

  def test_it_can_check_modulo_of_summed_digits_in_the_array
    credit_check = CreditCheck.new(6011797668867828)
    assert_equal "The number is valid!", credit_check.check_modulo
  end

  def test_invalide_numbers
    credit_check = CreditCheck.new(5541801923795240)
    assert_equal "The number is invalid!", credit_check.check_modulo

    credit_check = CreditCheck.new(4024007106512380)
    assert_equal "The number is invalid!", credit_check.check_modulo

    credit_check = CreditCheck.new(6011797668868728)
    assert_equal "The number is invalid!", credit_check.check_modulo

  end

  def test_more_valid_numbers
    credit_check = CreditCheck.new(4024007136512380)
    assert_equal "The number is valid!", credit_check.check_modulo

    credit_check = CreditCheck.new(5541808923795240)
    assert_equal "The number is valid!", credit_check.check_modulo
  end

end
