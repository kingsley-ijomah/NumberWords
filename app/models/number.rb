class Number < ActiveRecord::Base

  def self.number_words  
    {1000000 => "million", 1000 => "thousand", 100 => "hundred", 90 => "ninety", 80 => "eighty",
      70 => "seventy", 60 => "sixty", 50 => "fifty", 40 => "forty", 30 => "thirty", 20 => "twenty",
      19 => "nineteen", 18 => "eighteen", 17 => "seventeen", 16 => "sixteen", 15 => "fifteen",
      14 => "fourteen", 13 => "thirteen", 12 => "twelve", 11 => "eleven", 10 => "ten",
      9 => "nine", 8 => "eight", 7 => "seven", 6 => "six", 5 => "five", 4 => "four", 3 => "three",
      2 => "two", 1 => "one"}
  end

  def self.all page
    if page == nil
      page = 1
    else
      page = page.to_i
    end
    ending = page * per_page
    starting = ending - (per_page - 1)
    (starting..ending).to_a.map { |n| numbers_to_words n }
  end

  def self.numbers_to_words int
    str = ""
    number_words.each do |num, word|
      if int < 1
        return str
      elsif int.to_s.length == 1 && int%num == 0
        return str + "#{word}"      
      elsif int < 100 && int/num > 0
        return str + "#{word}" if int%num == 0
        return str + "#{word} " + numbers_to_words(int%num)
      elsif int/num > 0
        return str + numbers_to_words(int/num) + " #{word}" if int%num == 0
        return str + numbers_to_words(int/num) + " #{word} and " + numbers_to_words(int%num)
      end
    end
  end

  def self.pages n
    (n..per_page).map do |n|
      numbers_to_words(n)
    end
  end

  def self.total
    1000000
  end

  def self.per_page num: 1000
    num
  end

end