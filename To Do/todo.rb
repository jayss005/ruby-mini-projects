puts "Welcome to the Todo App!"

if File.exist?("tasks.txt")
  todos = File.readlines("tasks.txt").map(&:chomp)
else
  todos = []
end

while true
  puts "What would you like to do? (add, list, delete, done, exit)"
  choice = gets.chomp.strip.downcase

  case choice

  when "add"
    puts "Enter a new todo item:"
    todo = gets.chomp
    todos << todo
    puts "Todo added: #{todo}"

    File.write("tasks.txt", todos.join("\n"))

  when "list"
    puts "Your Todo List:"
    todos.each_with_index do |todo, index|
      puts "#{index + 1}. #{todo}"
    end

  when "delete"
    puts "Enter the number of the todo item to delete:"
    index = gets.chomp.to_i - 1

    if index >= 0 && index < todos.length
      removed = todos.delete_at(index)
      puts "Todo removed: #{removed}"

      File.write("tasks.txt", todos.join("\n"))
    else
      puts "Invalid index. Please try again."
    end

  when "done"
    puts "Enter the number of the todo item to mark as done:"
    index = gets.chomp.to_i - 1

    if index >= 0 && index < todos.length
      done_todo = todos[index]
      todos.delete_at(index)
      puts "Todo marked as done: #{done_todo}"

      File.write("tasks.txt", todos.join("\n"))
    else
      puts "Invalid index. Please try again."
    end

  when "exit"
    puts "Thank you for using the Todo App!"
    break

  else
    puts "Invalid choice. Please select add, list, delete, or exit."
  end
end