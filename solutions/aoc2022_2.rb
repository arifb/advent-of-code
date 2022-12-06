require "minitest/autorun"
require "./lib/input_parse"

def parse(filename)
  get_input_str_arr(filename).map { |plays| calc(plays) }.reduce(:+)
end

def parse2(filename)
  get_input_str_arr(filename).map { |plays| calc2(plays) }.reduce(:+)
end

def calc(moves)
  move1, move2 = moves[0], moves[2]
  if move1 == "A"
    return 4 if move2 == "X"
    return 8 if move2 == "Y"
    return 3 if move2 == "Z"
  elsif move1 == "B"
    return 1 if move2 == "X"
    return 5 if move2 == "Y"
    return 9 if move2 == "Z"
  else
    return 7 if move2 == "X"
    return 2 if move2 == "Y"
    return 6 if move2 == "Z"
  end
end

def calc2(moves)
  move1, move2 = moves[0], moves[2]
  if move1 == "A"
    return 3 if move2 == "X"
    return 4 if move2 == "Y"
    return 8 if move2 == "Z"
  elsif move1 == "B"
    return 1 if move2 == "X"
    return 5 if move2 == "Y"
    return 9 if move2 == "Z"
  else
    return 2 if move2 == "X"
    return 6 if move2 == "Y"
    return 7 if move2 == "Z"
  end
end

class TestAoc20222 < Minitest::Test
  def setup
  end
end

p parse("./input/aoc2022-2-1.test.txt")
p parse("./input/aoc2022-2-1.txt")

p parse2("./input/aoc2022-2-1.test.txt")
p parse2("./input/aoc2022-2-1.txt")
