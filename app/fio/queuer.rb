module FIO
  class Queuer
    def open(max, file)
      @files = Array.new(max)
      @indexes = Array.new(max)
      max.times do |i|
        @indexes[i] = 0
        @files[i] = File.open(file + (i + 1).to_s, 'r')
      end
    end
    def [](index)
      return -1 if @indexes[index] >= @indexes.length
      @indexes[index] += 1
      @files[index].read(4).unpack('L').first
    end
    def close
      @indexes.length.times { |i| @files[i].close }
    end
  end
end
