require "./lib/input_parse"
require "minitest/autorun"

def aoc221(path)
  str_groups_separated_by_blank_lines(path).map { |group| group.map(&:to_i).reduce(:+) }.max
end

def aoc222(path)
  str_groups_separated_by_blank_lines(path).map { |group| group.map(&:to_i).reduce(:+) }.sort[-3..].reduce(:+)
end

class TestAoc221 < Minitest::Test
  def test_aoc221
    assert_equal(24000, aoc221("./input/aoc2022-1-1.test.txt"))
  end
end

p aoc221("./input/aoc2022-1-1.txt")

p aoc222("./input/aoc2022-1-1.txt")
