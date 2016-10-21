require "tempfile"
require "file_utils"
require "zlib"

module FileWrangle
  VERSION = "0.1.0"
  class FileWrangle
    def initialize()
    end
    # Returns the compressed content
    def zip(input : String)
      File.open(input, "r") do |infile|
        File.open("ffs.tmp.gz", "w") do |outfile|
          Zlib::Deflate.gzip(outfile) do |deflate|
            IO.copy(infile, deflate)
          end
        end
      end
    end

    # Writes decompressed content to 'output'
    def unzip(input : String, output : String)
      data = File.open(input, "r") do |infile|
        Zlib::Inflate.gzip(infile) do |o|
          o.gets_to_end
        end
      end
      outfile = File.open(output, "w") do |outfile|
        outfile << data
      end
    end
  end
end