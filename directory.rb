def input_students
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  puts "Please enter name"
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    puts "Please enter hobby"
  hobby = gets.chomp
      puts "Please enter height"
  height = gets.chomp
    students << {name: name, hobby: hobby, height: height, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    puts "Please enter name"
    name = gets.chomp
  end
  # return the array of students
 students
end
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print(students)
  count = 0
 until count == students.count
   puts "#{students[count][:name]} #{students[count][:hobby]} #{students[count][:height]} (#{students[count][:cohort]} cohort)"
   count += 1
  end
end
def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
