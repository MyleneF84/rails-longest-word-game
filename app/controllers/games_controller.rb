class GamesController < ApplicationController
  require "open-uri"

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    word = params[:post]
    @letters = params[:letters].split(' ')

    word_letters = word.chars

    valid1 = word_letters.all? do |letter|
      present = @letters.include?(letter)
      @letters.delete_at(@letters.index(letter))
      present
    end
    valid2 = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read)["found"]

    if valid1 && valid2
      @response = "Congrats !!!!!!"
    elsif valid1 == false
      @response = "Sorry cannot do this word"
    else
      @response = "Not an english word"
    end
  end
end
