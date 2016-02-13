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

class Editor
	attr_accessor :subrip, :new_subrip, :time
	
	def initialize
		self.subrip = ""
		self.new_subrip = ""
		self.time = 0
	end

	def shift
		begin
			self.new_subrip = File.dirname(self.subrip) +"/"+ File.basename(self.subrip, ".srt") + "-shifted.srt" 
			File.open(self.new_subrip,"w:UTF-8") do |new_file|
				is_before_numeric = false
				File.readlines(self.subrip).each do |line|
					if (is_before_numeric) and (line.include?(" --> ")) and (line.split(" --> ").length == 2) and (line.split(" --> ")[0].include?(":")) and (line.split(" --> ")[1].include?(":"))  and (line.split(" --> ")[0].split(":").length == 3) and (line.split(" --> ")[1].split(":").length == 3)

						two_times_arr = line.split(" --> ")
						line_result = []
						two_times_arr.each do |time_string|
							time_arr = time_string.split(":")

							hours = time_arr[0].to_i
							minutes = time_arr[1].to_i
							seconds = time_arr[2].split(",").join(".").to_f
							time_sum = Time.gm(2016,1,1,hours,minutes,seconds) + self.time 
							
							hours = time_sum.hour.to_s
							hours = "0" + hours if hours.length == 1
								
							minutes = time_sum.min.to_s
							minutes = "0" + minutes if minutes.length == 1
								
							seconds = time_sum.sec.to_s
							seconds = "0" + seconds if seconds.length == 1
								
							miliseconds = time_sum.to_f.round(3).to_s.split(".").drop(1).join
							miliseconds = miliseconds + "0" if miliseconds.length == 2
							miliseconds = miliseconds + "00" if miliseconds.length == 1

							time_sum = hours + ":" + minutes+ ":" + seconds + "," + miliseconds

							line_result.push(time_sum)
						end
						new_file.puts line_result.join(" --> ")
						is_before_numeric = false
					else
						new_file.puts line
						is_before_numeric = Validator.integer?(line)
					end
				end
			end
			true
		rescue
			false
		end
	end
	
end