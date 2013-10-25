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
    # def set_env(env)
    #   @env = env
    #   @session = env['rack.session']
    #  end

    #  def some_key 
    #    return @session['some_key'].to_i if @session['some_key']
    #    @session['some_key'] = 0
    # end

    #  def some_key=(value)
    #    @session['some_key'] = value
    #   end

    def call(env)
       # set_env(env)
      req = Rack::Request.new(env)
      req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }
      computer_throw = @throws.sample
      player_throw = req.GET["choice"]
      answer = if !@throws.include?(player_throw)
          "Elijae una opcion:"
        elsif player_throw == computer_throw
          @jugadas['Empate'] += 1
          "¡Empate!"
        elsif computer_throw == @defeat[player_throw]
          @jugadas['Empate'] += 1
          "¡Bien! #{player_throw} gana a #{computer_throw}"
        else
          @jugadas['Empate'] += 1
          "Oohhh! #{computer_throw} gana a #{player_throw}. ¡Intentalo de nuevo!"
        end
      engine = Haml::Engine.new File.open("views/template.haml").read
      res = Rack::Response.new
       # self.some_key = self.some_key + 1 if req.path == '/'
       # res.write("some_key = #{@session['some_key']}\n")

      res.set_cookie("jugadas-Victoria", {:value => @jugadas['Victoria'], :path => "/", :domain => "", :expires => Time.now+24*60*60})
      res.set_cookie("jugadas-Empate", {:value => @jugadas['Empate'], :path => "/", :domain => "", :expires => Time.now+24*60*60})
      res.set_cookie("jugadas-Derrota", {:value => @jugadas['Derrota'], :path => "/", :domain => "", :expires => Time.now+24*60*60})
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
