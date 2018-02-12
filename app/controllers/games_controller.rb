require 'open-uri'
require 'json'

class GamesController < ApplicationController

 def new
   @letters = Array.new(10) { ('A'..'Z').to_a.sample }
 end

 def compare?(word)
   @letters = params[:answer2].split(" ")
   @test = word.upcase.split("")
   @test.all?{|letter| @letters.include?(letter)}
 end

 def score
   @answer = params[:answer]
   if english_word?(@answer)
     if compare?(@answer)
     @hello =  "well done"
     else
     @hello = "Can't be built out of your grid"
   end
   else
     @hello = "not an english word"
   end

 end

 def english_word?(word)
   response = open("https://wagon-dictionary.herokuapp.com/#{word}")
   json = JSON.parse(response.read)
   return json['found']
 end

end
