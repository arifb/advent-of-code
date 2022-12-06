require "./lib/input_parse"
require "minitest/autorun"

def parse(f)
  get_input_str_arr(f).map { |pairs| pairs.split(",") }
end

def pt1(data)
  data.reduce(0) do |memo, datum|
    pair = datum.map do |range|
      start, finish = range.split("-")
      [start.to_i, finish.to_i]
    end
    # is pair1 in pair0 or pair0 in pair1?
    memo += 1 if (pair[1][0] >= pair[0][0] && pair[1][1] <= pair[0][1]) || (pair[0][0] >= pair[1][0] && pair[0][1] <= pair[1][1])
    memo
  end
end

def pt1_range(data)
  parsed = data.map do |datum|
    datum.map { |d| Range.new(d.split("-")[0].to_i, d.split("-")[1].to_i) }
  end
  parsed.reduce(0) do |memo, ranges|
    memo += 1 if ranges[0].cover?(ranges[1]) || ranges[1].cover?(ranges[0])
    memo
  end
end

def pt2_range(data)
  parsed = data.map do |datum|
    datum.map { |d| Range.new(d.split("-")[0].to_i, d.split("-")[1].to_i) }
  end
  parsed.reduce(0) do |memo, ranges|
    memo += 1 if ranges[1].cover?(ranges[0].min) ||
      ranges[1].cover?(ranges[0].max) ||
      ranges[0].cover?(ranges[1].min) ||
      ranges[0].cover?(ranges[1].max)
    memo
  end
end

def pt2(data)
  data.reduce(0) do |memo, datum|
    pair = datum.map do |range|
      start, finish = range.split("-")
      [start.to_i, finish.to_i]
    end
    range_a, range_b = pair[0], pair[1]
    array_a = Array.new(1000) do |idx|
      if idx >= range_a[0] && idx <= range_a[1]
        "x"
      end
    end
    array_b = Array.new(1000) do |idx|
      if idx >= range_b[0] && idx <= range_b[1]
        "x"
      end
    end
    compare = array_a.each_with_index.map { |a, idx| a == array_b[idx] && a == "x" ? "x" : nil }
    memo += 1 if compare.compact.length > 0
    memo
  end
end

class TestAoc20224 < Minitest::Test
  def test_pt1
    assert_equal(2, pt1(parse("./input/aoc2022-4-1.test.txt")))
  end

  def test_pt1_range
    assert_equal(2, pt1_range(parse("./input/aoc2022-4-1.test.txt")))
  end

  def test_pt2
    assert_equal(4, pt2(parse("./input/aoc2022-4-1.test.txt")))
  end

  def test_pt2_range
    assert_equal(4, pt2_range(parse("./input/aoc2022-4-1.test.txt")))
  end

  def test_parse
    assert(parse("./input/aoc2022-4-1.test.txt"))
  end
end

p pt1(parse("./input/aoc2022-4-1.txt"))
p pt1_range(parse("./input/aoc2022-4-1.txt"))
p pt2(parse("./input/aoc2022-4-1.txt"))
p pt2_range(parse("./input/aoc2022-4-1.txt"))
