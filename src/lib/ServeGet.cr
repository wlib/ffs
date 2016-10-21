require "socket"
require "file_utils"
require "./*"
include FileWrangle

module ServeGet
  VERSION = "0.1.0"
  class ServeGet
    def initialize()
    end
    
    # Does file checks, if they pass it compresses file and listens for client
    def serve(sfile : String, port : String)
      filewrangle = FileWrangle::FileWrangle.new
      if sfile == ""
        puts "[-] File not specified".error; exit
      elsif !File.exists?(sfile)
        puts "[-] File does not exist".error; exit
      else
        server = TCPServer.new(port.to_i)
        puts "[+] Server online".good
      end
      filewrangle.zip(sfile)
      data = File.read("ffs.tmp.gz")
      puts "[*] Serving compressed file".info
      FileUtils.rm_r("ffs.tmp.gz")
      while true
        Signal::INT.trap do
          puts "\n[*] Server Stopped".info; exit
        end
        # If the client connects, send file to client and close connection
        server.accept do |client|
          puts "[+] Connection accepted from a client".good
          client << data
          puts "[*] Sent file to client, ended connection".info
          client.close
          puts "[*] Server can continue sending files".info
        end
      end
    end
    
    # Does argument checks, if they pass it connects to the server
    def get(sip : String, port : String, rfile : String)
      filewrangle = FileWrangle::FileWrangle.new
      if sip == ""
        puts "You didn't set the server IP address".error; exit
      else
        socket = TCPSocket.new("#{sip}", port)
        puts "[+] Client Connected".good
      end
      Signal::INT.trap do
        puts "\n[*] Client Stopped".info; exit
      end
      if socket.nil?
        puts "[-] Server not reached or responding".error; exit
      elsif !socket.nil?
        puts "[+] Downloading...".good
      end
      # If the output file was set, write to that file, if not, write to a new one
      defaultfile = "ffs.out"
      i = 0
      while File.exists?(defaultfile)
        if true
          defaultfile = "ffs#{i}.out"
          i += 1
        end
      end
      if rfile == ""
        puts "[*] Filename not set, writing to #{defaultfile}".warn
        rfile = defaultfile
      end
      # Decompress the content downloaded from the server and write it
      zipped = File.open("ffs.tmp", "w+") do |zipped|
        IO.copy(socket, zipped)
      end
      puts "[+] File transfer done!".good
      filewrangle.unzip("ffs.tmp", rfile)
      FileUtils.rm_r("ffs.tmp")
    end
  end
end