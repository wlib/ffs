require "option_parser"
require "colorize"
require "./ffs/*"
require "./lib/FileWrangle"
require "./lib/ServeGet"
include FileWrangle
include ServeGet

# Colored text
class String
  def info
    self.colorize(:light_gray)
  end

  def good
    self.colorize(:green) 
  end

  def warn
    self.colorize(:yellow).mode(:underline) 
  end

  def error
    self.colorize(:red).mode(:bold) 
  end
end

# The CLI Arguments
class Args
  property server : Bool = false
  property client : Bool = false
  property sip : String = "localhost"
  property port : String = "1174"
  property sfile : String = ""
  property rfile : String = ""
end

args = Args.new

# Option parser does its thing here
OptionParser.parse! do |parser|
  parser.banner = "Usage: ffs [options]"
  parser.on("-s", "--server", "Starts as a server") { args.server = true }
  parser.on("-c", "--client", "Starts as a client") { args.client = true }
  parser.on("-i IP", "--ip=IP", "Sets the server's ip address") { |o| args.sip = o }
  parser.on("-p PORT", "--port=PORT", "Sets a different port number") { |o| args.port = o }
  parser.on("-f FILE", "--file=FILE", "Gives the filename the server will share") { |o| args.sfile = o }
  parser.on("-o FILE", "--output=FILE", "Gives an optional output filename for the client") { |o| args.rfile = o }
  parser.on("-h", "--help", "Displays this help message") { puts parser; exit }
end

action = ServeGet::ServeGet.new

# Where the program starts to run
if args.server
  args.client = false
  action.serve(args.sfile, args.port)
elsif args.client
  args.server = false
  action.get(args.sip, args.port, args.rfile)
else
  puts "Not set to either server or client, run `ffs --help` for help".error; exit
end