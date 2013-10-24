require 'spec_helper'

describe RockPaperScissors::App do
  #let(:server) { Rack::MockRequest.new(RockPaperScissors::App.new) }
  def server
    Rack::MockRequest.new(RockPaperScissors::App.new)
  end

  context '/' do
    it "Debería retornar el código 200" do
      response = server.get('/')
      response.status.should == 200
    end
    it "Debería mostrar Bienvenido a Piedra Papel y Tijera" do
      response = server.get('/')
      response.body == 'Bienvenido a Piedra Papel y Tijera'
    end
  end
end