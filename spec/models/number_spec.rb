require 'rails_helper'

RSpec.describe Number, type: :model do
  describe 'number words' do
  	it 'defines number words' do 
  		expect(Number.number_words.count).to eq 30
  	end

  	it 'matches the expected number words' do
  		number_words = {1000000 => "million", 1000 => "thousand", 100 => "hundred", 90 => "ninety", 80 => "eighty",
      70 => "seventy", 60 => "sixty", 50 => "fifty", 40 => "forty", 30 => "thirty", 20 => "twenty",
      19 => "nineteen", 18 => "eighteen", 17 => "seventeen", 16 => "sixteen", 15 => "fifteen",
      14 => "fourteen", 13 => "thirteen", 12 => "twelve", 11 => "eleven", 10 => "ten",
      9 => "nine", 8 => "eight", 7 => "seven", 6 => "six", 5 => "five", 4 => "four", 3 => "three",
      2 => "two", 1 => "one"}
      expect(number_words).to eq Number.number_words
  	end
  end

  describe 'number to words' do
  	it 'change numerals to words' do 
  		expect(Number.numbers_to_words 0.21).to eq ''
  		expect(Number.numbers_to_words -1).to eq ''
  		expect(Number.numbers_to_words 1).to eq 'one'
  		expect(Number.numbers_to_words 99).to eq 'ninety nine'
  		expect(Number.numbers_to_words 1000000).to eq 'one million'
  		expect(Number.numbers_to_words 1000001).to eq 'one million and one'
  	end
  end
end