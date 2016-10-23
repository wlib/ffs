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
        File.open("ffs.tmp.gz", "w") do |outfile|
        Zlib::Deflate.gzip(outfile) do |deflate|
          FileUtils.copy(input, deflate)
        end
      end
    end

    # Writes decompressed content to 'output'
    def unzip(input : String, output : String)
      data = File.read(input) do |infile|
        Zlib::Inflate.gzip(infile) do |unzipped|
          unzipped.gets_to_end
        end
      end
      File.open(output, "w") do |outfile|
        outfile << data
      end
    end
  end
end
