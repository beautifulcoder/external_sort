require 'test/unit'
require 'mocha/setup'
require_relative '../app/sort'

class SortTest < Test::Unit::TestCase
  def test_sort_external
    writer = mock()
    reader = mock()
    queuer = mock()
    reader.expects(:open).with('in').at_least_once
    reader.expects(:read).times(9)
    reader.expects(:close).at_least_once
    writer.expects(:open).with('out').at_least_once
    writer.expects(:open).with('in1').at_least_once
    writer.expects(:open).with('in2').at_least_once
    writer.expects(:open).with('in3').at_least_once
    writer.expects(:append).with(anything).times(18)
    writer.expects(:close).at_least_once
    queuer.expects(:open).with(3, 'in').at_least_once
    queuer.expects(:[]).with(anything).times(12).returns(0)
    queuer.expects(:close).at_least_once
    Sort.new(reader, writer, queuer).external(9, 3, 'in', 'out')
  end
  def test_sort_external_edge_case
    writer = mock()
    reader = mock()
    queuer = mock()
    reader.expects(:open).with('in').at_least_once
    reader.expects(:read).times(1)
    reader.expects(:close).at_least_once
    writer.expects(:open).with('out').at_least_once
    writer.expects(:open).with('in1').at_least_once
    writer.expects(:append).with(anything).times(2)
    writer.expects(:close).at_least_once
    queuer.expects(:open).with(1, 'in').at_least_once
    queuer.expects(:[]).with(anything).times(2)
    queuer.expects(:close).at_least_once
    Sort.new(reader, writer, queuer).external(1, 1, 'in', 'out')
  end
end
