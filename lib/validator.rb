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

module Validator

	def self.integer? (value)
		Integer(value) != nil rescue false
	end

	def self.numeric? (value)
		Float(value) != nil rescue false
	end

	def self.is_a_valid_answer? (answer, valid_options)
		valid_options.include?(answer.downcase)
	end

	def self.is_a_valid_subrip_file? (path)
		if (path.end_with?("' ") or path.end_with?("'")) and (path.start_with?("'"))
			path.end_with?("' ") ? path.chop!.chop! : path.chop!
			path.slice!(0)
		end 
		is_file = File.exist?(path)
		is_file_format = File.basename(path).end_with?(".srt")
		is_file and is_file_format
	end

end