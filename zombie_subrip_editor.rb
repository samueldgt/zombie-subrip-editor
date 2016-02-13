#!/usr/bin/env ruby

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

require_relative "lib/validator"
require_relative "lib/user_interface"
require_relative "lib/editor"

all_valid_answers = ["y","yes","n","no","exit"]
yes_valid_answers = ["y","yes"]
no_valid_answers = ["n","no","exit"]
exit_valid_answers = ["exit"]

continue = false
interface = UserInterface.new
subrip_editor = Editor.new
begin
	exit = false
	valid = true
	success = false
	if !continue
		begin
			answer = interface.agree_with_terms?
			exit = Validator.is_a_valid_answer?(answer, no_valid_answers)
			valid = Validator.is_a_valid_answer?(answer, yes_valid_answers)
		end until valid or exit
	end
	if	!exit
		begin
			answer = interface.get_a_subrip(valid)
			exit = Validator.is_a_valid_answer?(answer, exit_valid_answers)
			valid = Validator.is_a_valid_subrip_file?(answer)
		end until valid or exit
		if !exit 
			subrip_editor.subrip = answer
			begin
				answer = interface.get_the_shift_time(valid)
				exit = Validator.is_a_valid_answer?(answer, exit_valid_answers)
				valid = Validator.numeric?(answer)
			end until valid or exit
			if !exit
				subrip_editor.time = answer.to_f
				success = subrip_editor.shift
			end
		end
	end

	if exit
		break
	elsif success
		begin
			answer = interface.success(subrip_editor.new_subrip)
		end until Validator.is_a_valid_answer?(answer, all_valid_answers)
		continue = Validator.is_a_valid_answer?(answer, yes_valid_answers)
		exit = Validator.is_a_valid_answer?(answer, no_valid_answers)
	else
		begin
			answer = interface.not_success
		end until Validator.is_a_valid_answer?(answer, all_valid_answers)
		continue = Validator.is_a_valid_answer?(answer, yes_valid_answers)
		exit = Validator.is_a_valid_answer?(answer, no_valid_answers)
	end
end until exit

interface.exit