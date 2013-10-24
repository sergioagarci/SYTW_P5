#encoding: utf-8
require 'rack/request'
require 'rack/response'
require 'haml'
 
module RockPaperScissors
  class App
    def initialize(app = nil)
      @app = app
      @content_type = :html
      @defeat = {'Piedra' => 'Tijera', 'Papel' => 'Piedra', 'Tijera' => 'Papel'}
      @throws = @defeat.keys
      @jugadas = {'Empate' => 0, 'Derrota' => 0, 'Victoria' => 0}
    end

    def call(env)
      req = Rack::Request.new(env)
      req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }
      computer_throw = @throws.sample
      player_throw = req.GET["choice"]
      answer = if !@throws.include?(player_throw)
          "Elijae una opcion:"
        elsif player_throw == computer_throw
          "¡Empate!"
        elsif computer_throw == @defeat[player_throw]
          "¡Bien! #{player_throw} gana a #{computer_throw}"
        else
          "Oohhh! #{computer_throw} gana a #{player_throw}. ¡Intentalo de nuevo!"
        end
      engine = Haml::Engine.new File.open("views/index.haml").read
      res = Rack::Response.new
      res.write engine.render(
        {},
        :answer => answer,
        :throws => @throws,
        :computer_throw => computer_throw,
        :player_throw => player_throw)
      res.finish
    end # call
  end # App
end # RockPaperScissors
