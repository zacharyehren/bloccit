#we define RandomData as a module because it is a standalone library with no dependencies or inheritance requirements
module RandomData
  def self.random_name
     first_name = random_word.capitalize
     last_name = random_word.capitalize
     "#{first_name} #{last_name}"
   end

   def self.random_email
     "#{random_word}@#{random_word}.#{random_word}"
   end

#we define random_paragraph
  def self.random_paragraph
  #we set sentences to an array
    sentences = []
    #we create 4 - 6 random sentences and append them to sentences
    rand(4..6).times do
      sentences << random_sentence
    end
    #we call join on sentences to combine each sentence in the array, passing a space to separate each sentence
    #join combines each sentence into a full paragraph (as a string)
    sentences.join(" ")
  end

#we follow the same pattern as we did above to create a sentence with a random number of words
  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    #after we generate a sentence, we call capitalize on it and append a period
    #capitalize returns a copy of sentence with the first character converted to uppercase and the remainder converted to lowercase
    sentence.capitalize << "."
  end

  def self.random_word
    #we set letters to an array of letters a through z using to_a
    letters = ('a'..'z').to_a
    #we call shuffle! on letters in place. If we were to call shuffle without the bang, shuffle would return rather than shuffle in place
    letters.shuffle!
    #we join the zeroth through nth item in letters. The nth item is the result of rand(3..8) which returns a random number greater than or equal to three and less than 8
    letters[0,rand(3..8)].join
  end
end
