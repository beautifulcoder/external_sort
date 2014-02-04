class Export
  def initialize(writer)
    @writer = writer
  end
  def out(max, file_name)
    @writer.open(file_name)
    max.times { @writer.append(Random.rand 10) }
    @writer.close
  end
end
