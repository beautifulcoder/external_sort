require_relative 'check'
require_relative 'export'
require_relative 'sort'
require_relative 'fio/queuer'
require_relative 'fio/reader'
require_relative 'fio/writer'

if ARGV.length < 2
  puts 'Usage: ruby start N filename'
  exit
end

N = ARGV[0].to_i
M = N * N
f_in = ARGV[1]
f_out = f_in + '.out'
reader = FIO::Reader.new
writer = FIO::Writer.new
queuer = FIO::Queuer.new
Export.new(writer).out(M, f_in)
Sort.new(reader, writer, queuer).external(M, N, f_in, f_out)
if Check.new(reader).is_sorted(M, f_out)
  puts 'OK!'
else
  puts 'ERROR: ' + f_out + ' is not sorted'
end
