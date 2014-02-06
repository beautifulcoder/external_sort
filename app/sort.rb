class Sort
  def initialize(reader, writer, queuer)
    @reader = reader
    @writer = writer
    @queuer = queuer
  end
  def external(max, cache_size, file_in, file_out)
    capacity = Array.new(cache_size)
    # Break file_in into chunks
    @reader.open(file_in)
    max.times do |index|
      capacity[index % cache_size] = @reader.read
      if is_end_of_chunk(index, max, cache_size)
        capacity.sort!
        @writer.open(file_in + ((index + 1) / cache_size).to_s)
        cache_size.times { |i| @writer.append(capacity[i]) }
        @writer.close
      end
    end
    @reader.close
    # Merge chunks onto file_out
    @writer.open(file_out)
    @queuer.open(cache_size, file_in)
    cache_size.times { |i| capacity[i] = @queuer[i] }
    max.times do
      lowest = min_index(capacity)
      @writer.append(capacity[lowest])
      capacity[lowest] = @queuer[lowest]
    end
    @queuer.close
    @writer.close
  end

  private
    def is_end_of_chunk(index, max, size)
      (!index.zero? && ((index + 1) % size).zero?) || max == 1
    end
    def min_index(arr)
      index = 0
      (1..arr.length - 1).each do |i|
        next if arr[i].nil?
        index = i if arr[index].nil? || arr[index] > arr[i]
      end
      index
    end
end
