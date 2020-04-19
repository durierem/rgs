# frozen_string_literal: true

require './src/simulation.rb'
require './src/parameters.rb'

if ARGV.length < 3
  puts('[ERROR] Missing arguments')
  exit
end

Parameters.duration = ARGV[0].to_i
Parameters.initial_pop_size = ARGV[1].to_i
Parameters.max_offsprings = ARGV[2].to_i

unless Parameters.valid?
  puts('[ERROR] Invalid simulation parameters')
  exit
end

Simulation.new.show
