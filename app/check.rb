class Check
  def initialize(reader)
    @reader = reader
  end
  def is_sorted(max, file_out)
    return true if max <= 1
    sorted = true
    @reader.open(file_out)
    a = @reader.read
    (max - 1).times do
      b = @reader.read
      sorted = false if a > b
      a = b
    end
    @reader.close
    sorted
  end
end
