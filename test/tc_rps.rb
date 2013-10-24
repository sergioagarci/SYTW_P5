require "test/unit"
require "rack/test"
require "rsack"

class RPSTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      run RockPaperScissors::App.new
    end.to_app
  end