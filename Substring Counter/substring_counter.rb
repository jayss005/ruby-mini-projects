def substrings(word, dictionary)
  result = {}
  word_down = word.downcase
  dictionary.each do |sub|
    sub_down = sub.downcase
    count = 0
    start = 0
    while (index = word_down.index(sub_down, start))
      count += 1
      start = index + 1
    end
    result[sub] = count if count > 0
  end
  result
end

puts "Enter a word:"
word = gets.chomp

puts "Enter a list of substrings (comma separated):"
dictionary = gets.chomp.split(",").map(&:strip)

result = substrings(word, dictionary)
puts "Substrings found in the word:"
result.each do |sub, count|
  puts "#{sub}: #{count}"
end