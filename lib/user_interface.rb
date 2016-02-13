# Zombie SubRip Editor v0.1
# Copyright (c) 2016 Samuel Gonzalez
# This program is distributed under terms of the GNU General Public License.

=begin 
	This file is part of Zombie SubRip Editor.

    Zombie SubRip Editor is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Zombie SubRip Editor is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Zombie SubRip Editor. If not, see <http://www.gnu.org/licenses/>.
=end

class UserInterface

	REMEMBER = "*** Remember: You can write \"EXIT\" and press ENTER if you want to exit of the application\n\n"

	def agree_with_terms?
		system "clear"
		puts "--- Welcome to Zombie SubRip Editor v0.1 ---\n\n"
		puts "This Open Source software allows you to shift the entire time of a subrip subtitle file (extensión .srt) by passing to the program the path of yor .srt file and the time you want to shift.\n\n"

		puts "*** Terms: ***"
		puts "This program is distributed under terms of the GNU General Public License.\n\n"

		puts "*** How it Works: ***"
		puts "1. The software ask you the full path of your file."
		puts "2. The software ask you the value of time you want to shift."
		puts "3. The software shift the time and returns a new edited file with another name in the same path of the original file.\n\n" + REMEMBER

		puts "*** Important: ***"
		puts "1. This software needs a existing file path."
		puts "2. This software needs the full path of your file, i.e."
		puts "\"#{Dir.pwd}/example-file.srt\""
		puts "3. This software works with SubRip's valid formats, your file must be \".srt\" extension. \n\n"

		puts "Write your answer in the console and press ENTER to continue"
		puts "Do you agree the terms and conditions? (Y/N)"
		answer = gets.chomp
	end

	def get_a_subrip (valid)
		system "clear"
		puts "ERROR: Wrong path name or file format, please check at your file path, copy the full path and try again (your file must be .srt extension).\n\n" + REMEMBER if !valid

		puts "*** Choosing your subrip file: ***\n\n"
		puts "Option 1. Check your file properties, copy the entire path and paste it here using the right clic and paste, or using the keyboard comand (CRTL + SHIFT + V), and press ENTER to continue"
		puts "Option 2. You can drag and drop the file from your folder to the terminal console, then the entire path will be pasted automatically, and press ENTER to continue"
		answer = gets.chomp
	end

	def get_the_shift_time (valid)
		system "clear"
		puts "ERROR: Wrong time format, please check the rules again and enter a valid numeric value for the time\n\n" + REMEMBER if !valid

		puts "*** Choosing the shift time: ***\n\n"
		puts "Please enter the time in a valid format (seconds.milliseconds) to shift the SubRip file's time, i.e.:\n\n" 
		puts "If you want to move the timeline backward 2.5 seconds, then enter \"-2.5\" (without quotes), and if you want to move the time forward enter \"-2.5\" (without quotes)\n\n"
		puts "Enter the time value and press ENTER:"
		answer = gets.chomp
	end

	def not_success
		system "clear"
		puts "Sorry, we have experimented an unexpected error during the program execution, please check your .srt file to verify if it contains valid information, also verify your subrip's path permissions because it could be blocked to create/edit files.\n\n" + REMEMBER
		puts "Write your answer in the console and press ENTER to continue"
		puts "Do you want to try again with another file? (Y/N)"
		answer = gets.chomp
	end

	def success (path)
		system "clear"
		puts "*** Your file was shifted correctly ***\n\n"
		puts "It was saved with another name at the same path, the new name is the same as the original file but with \"-shifted\" at the end of the name\n\n"
		puts "This is the new file name and the entire path: \n\n" 
		puts path + "\n\n"
		puts "Write your answer in the console and press ENTER to continue"
		puts "Do you want to try again with another file? (Y/N)"
		answer = gets.chomp
	end

	def exit
		system "clear"
		puts "Thanks for use this software"
		puts "The program will be closed after this message"
		puts "Press ENTER to exit..."
		gets
		system "clear"
	end
	
end