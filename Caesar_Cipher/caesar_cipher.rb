# Code for Caesar Cipher
def caesar_cipher(str,shift)
    result =""
    alphabet = ("a".."z").to_a
    str.each do |char|
        if alphabet.include?(char)
            index = alphabet.index(char)
            new_index = (index + shift) % 26
            result += alphabet[new_index]
        else
            result += char
        end
    end
    result
end

puts "Enter a string to encrypt:"
str = gets.chomp.downcase.split("")

puts "Enter the shift values:"
shift = gets.chomp.to_i

encrypted_str = caesar_cipher(str, shift)
puts "The Final Encrypted String is: #{encrypted_str} "