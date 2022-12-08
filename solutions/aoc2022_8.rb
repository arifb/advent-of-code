require "./lib/input_parse"
require "minitest/autorun"

def parse(filepath)
  get_input_str_arr(filepath)
end

def solve_pt1(heights)
  heights.map.with_index do |row, ri|
    row.chars.map.with_index do |c, ci|
      # take care of first and last row
      if ri == 0 || ri == heights.length - 1
        "v"
      # take care of first and last height along vertical sides
      elsif ci == 0 || ci == row.length - 1
        "v"
      # look left / right
      elsif c.to_i > row[0..ci - 1].chars.map(&:to_i).max ||
          c.to_i > row[ci + 1..].chars.map(&:to_i).max
        "v"
      # look up / down
      elsif c.to_i > heights[0..ri - 1].map { |h| h[ci].to_i }.max ||
          c.to_i > heights[ri + 1..].map { |h| h[ci].to_i }.max
        "v"
      end
    end
  end.reduce(0) do |acc, row|
    acc += row.count("v")
    acc
  end
end

def solve_pt2(heights)
  heights.map.with_index do |row, ri|
    row.chars.map.with_index do |c, ci|
      lt, rt, up, down = 0, 0, 0, 0
      if ri == 0 || ri == heights.length - 1
        0
      elsif ci == 0 || ci == row.length - 1
        0
      else
        (ci - 1).downto(0) do |lookleft|
          lt += 1
          break if row[lookleft].to_i >= c.to_i
        end
        (ci + 1).upto(row.length - 1) do |lookright|
          rt += 1
          break if row[lookright].to_i >= c.to_i
        end
        (ri - 1).downto(0) do |lookup|
          up += 1
          break if heights[lookup][ci].to_i >= c.to_i
        end
        (ri + 1).upto(heights.length - 1) do |lookdown|
          down += 1
          break if heights[lookdown][ci].to_i >= c.to_i
        end
        lt * rt * up * down
      end
    end
  end.map { |row| row.max }.max
end

class TestAoc20226 < Minitest::Test
  def test_solve_pt1
    assert_equal(21, solve_pt1(parse("./input/aoc2022-8-1.test.txt")))
  end

  def test_solve_pt2
    assert_equal(8, solve_pt2(parse("./input/aoc2022-8-1.test.txt")))
  end
end

p solve_pt1(parse("./input/aoc2022-8-1.txt"))
p solve_pt2(parse("./input/aoc2022-8-1.txt"))
