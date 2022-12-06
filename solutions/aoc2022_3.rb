require "./lib/input_parse"
require "minitest/autorun"

def aoc2231(path)
  priorities = ("a".."z").to_a.concat(("A".."Z").to_a).unshift(nil)
  rucksacks = get_input_str_arr(path)
  rucksacks.reduce(0) do |memo, rucksack|
    comp1 = rucksack[0..rucksack.length / 2 - 1]
    comp2 = rucksack[rucksack.length / 2..]
    common = comp1.chars & comp2.chars
    memo += priorities.index(common[0])
    memo
  end
end

def aoc2232(path)
  priorities = ("a".."z").to_a.concat(("A".."Z").to_a).unshift(nil)
  rucksacks = get_input_str_arr(path)
  total = 0
  rucksacks.each_slice(3) do |slice|
    common = slice[0].chars & slice[1].chars & slice[2].chars
    total += priorities.index(common[0])
  end
  total
end

class TestAoc223 < Minitest::Test
  def test_aoc223
    assert_equal(157, aoc2231("./input/aoc2022-3-1.test.txt"))
    assert_equal(70, aoc2232("./input/aoc2022-3-1.test.txt"))
  end
end

p aoc2231("./input/aoc2022-3-1.txt")
p aoc2232("./input/aoc2022-3-1.txt")
