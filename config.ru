require './lib/rsack/rps.rb'
builder = Rack::Builder.new do
      use Rack::Static, :urls => ['/public']
      use Rack::ShowExceptions
      use Rack::Lint
      run RockPaperScissors::App.new
end

Rack::Handler::WEBrick.run builder, :Port => 8080


