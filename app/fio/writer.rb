module FIO
  class Writer
    def open(file)
      @file = File.open(file, 'w')
    end
    def append(n)
      @file.write [n].pack('L')
    end
    def close
      @file.close
    end
  end
end
