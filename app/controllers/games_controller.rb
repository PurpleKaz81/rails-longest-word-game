require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @response = params[:answer].split('')
    if @response.any? { |letter| !@letters.include? letter }
      @response = 'Try again!'
    else
      @response = check_word(params[:answer])
    end
  end

  def check_word(response)
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{response}").read
    answer = JSON.parse(url)
    if answer['found']
      answer['length']
    else
      'No such word'
    end
  end
end
