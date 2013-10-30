require "test/unit"
require "rack/test"
require "rsack"

module RockPaperScissors

class RPSTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      run RockPaperScissors::App.new
    end.to_app
  end

  def test_index
    get "/"
    assert last_response.ok?
  end

  def test_body
    get "/"
    assert last_response.body.include? ("Bienvenido a Piedra Papel y Tijera")
  end
 
   def test_title
    get "/"
    assert_match "Piedra Papel Tijera", last_response.body
  end

  def test_rock
    get "/?choice=piedra"
    assert last_response.ok?
  end
  
  def test_paper
    get "/?choice=papel"
    assert last_response.ok?
  end
  
  def test_scissors
    get "/?choice=tijera"
    assert last_response.ok?
  end
end
end