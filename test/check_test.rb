require 'test/unit'
require 'mocha/setup'
require_relative '../app/check'

class CheckTest < Test::Unit::TestCase
  def test_check_is_sorted
    reader = mock()
    reader.expects(:open).with('out').at_least_once
    reader.expects(:read).times(9).returns(0)
    reader.expects(:close).at_least_once
    target = Check.new(reader).is_sorted(9, 'out')
    assert target
  end
  def test_check_is_not_sorted
    reader = mock()
    reader.expects(:open).with('out').at_least_once
    args = [0, 1, 3, 2, 4, 5, 6, 7, 8, 9]
    reader.expects(:read).times(9).returns(*args)
    reader.expects(:close).at_least_once
    target = Check.new(reader).is_sorted(9, 'out')
    assert !target
  end
end
