# frozen_string_literal: true

require './util/assertion_error.rb'
require './individual.rb'
require './parameters.rb'

# A couple of two individuals that can reproduce.
# @inv
#   members.length == 2 && members.each { |m| m.is_a?(Individual) }
#   && 0 <= offsprings.length <= max_offsprings
#   && offsprings.each { |p| p.is_a?(Individual) }
class Couple
  attr_reader :members, :offsprings, :max_offsprings

  # A new couple formed by two indivuals.
  # @pre
  #   ind_a.compatible?(ind_b)
  # @post
  #   members.include(ind_a) && members.include?(ind_b)
  #   && offsprings.empty?
  #   && ind_a.paired? && ind_b.paired?
  def initialize(ind_a, ind_b)
    unless ind_a.compatible?(ind_b)
      raise AssertionError, 'Incompatible individuals'
    end

    @members = [ind_a, ind_b]
    @offsprings = []
    ind_a.couple = self
    ind_b.couple = self
  end

  # Makes the couple reproduce.
  #
  # Offsprings' sex are determined randomly.
  # @post
  #   offsprings.length == Random.rand(1, max_offsprings)
  def breed
    Random.rand(0..Parameters.max_offsprings).times do
      @offsprings.push(Individual.new(Individual::SEXES.sample))
    end
  end

  # Returns a human-readable string representation of this couple.
  def describe
    "#<Couple:#{object_id} @members=#{@members} @offsprings=#{@offsprings}>"
  end
end
