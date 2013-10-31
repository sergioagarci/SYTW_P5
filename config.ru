require './lib/rsack/rps.rb'
builder = Rack::Builder.new do
      use Rack::Static, :urls => ['/public']
      use Rack::ShowExceptions
      use Rack::Lint
      use Rack::Session::Cookie, 
      	:key => 'rack.session', 
      	:secret => 'some_secret'
      run RockPaperScissors::App.new
end

Rack::Handler::WEBrick.run builder, :Port => 8080


