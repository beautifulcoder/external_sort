module FIO
  class Reader
    def open(file)
      @file = File.open(file, 'r')
    end
    def read
      @file.read(4).unpack('L').first
    end
    def close
      @file.close
    end
  end
end
