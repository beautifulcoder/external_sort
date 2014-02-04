require 'test/unit'
require 'mocha/setup'
require_relative '../app/export'

class ExportTest < Test::Unit::TestCase
  def test_export_out
    writer = mock()
    writer.expects(:open).with('in').at_least_once
    writer.expects(:append).with(anything).times(9)
    writer.expects(:close).at_least_once
    Export.new(writer).out(9, 'in')
  end
end
