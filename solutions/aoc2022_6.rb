require "./lib/input_parse"
require "minitest/autorun"

def parse(filepath)
  get_input_str_arr(filepath)
end

def solve(buffers, lastn)
  buffers.map do |buffer|
    prev = []
    idx_last_add = nil
    buffer.chars.each_with_index do |char, i|
      idx_last_add = i
      prev.shift unless prev.compact.length < lastn
      prev.push(char)
      break if prev.compact.length == lastn && prev.uniq.length == lastn
    end
    idx_last_add + 1
  end
end

def solve_pt2
end

class TestAoc20226 < Minitest::Test
  def test_solve_pt1
    assert_equal([7, 5, 6, 10, 11], solve(parse("./input/aoc2022-6-1.test.txt"), 4))
  end
end

p solve(parse("./input/aoc2022-6-1.txt"), 4).first
p solve(parse("./input/aoc2022-6-1.txt"), 14).first