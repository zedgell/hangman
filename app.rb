require 'sinatra'
require_relative 'hangman.rb'

get '/' do 
  erb :index   
end

get '/start' do
  my_game = Hangman.new 
  @session = session 
  session = my_game.set_new_session(@session)
  session["length"] = "Number of letters: #{session["secret_word"].length}"
  redirect 'play'
end

get '/play' do
  my_game = Hangman.new
  @session = session
  my_game.set_current_session(@session)
  redirect 'start' if my_game.player_won? != nil 
  toon = my_game.make_guess(params)
  @session = session 
  session = my_game.set_new_session(@session) 
  erb :play, :locals => {:display => my_game.display_content, 
                         :toon => toon, :length => session["length"]}
end 