require "./lib/input_parse"
require "minitest/autorun"

# lets get them in stacks, need to parse each line
# then convert the same index of each array to stacks/new arrays
def parse(f)
  # get_input_str_arr(f).map { |s| s.scan("/\w/") }
  input = get_input_str_arr(f)
  row_count = 0
  stacks = Array.new(1000) { [] }
  input.each do |row|
    break if row[1] == "1"
    row.chars.each_with_index do |c, idx|
      if c.match?(/\w/)
        stacks[idx / 4].unshift(c)
      end
    end
    row_count += 1
  end
  row_count += 2
  instructions = input[row_count..].map do |instruction|
    instruction.scan(/\d+/).map(&:to_i)
  end
  [stacks, instructions]
end

def solve_pt1(f)
  stacks, instructions = parse(f)
  instructions.each do |instruction|
    crates = stacks[instruction[1] - 1].pop(instruction[0])
    stacks[instruction[2] - 1].push(crates.reverse).flatten!
  end
  stacks.compact.map { |s| s[-1] }.join
end

def solve_pt2(f)
  stacks, instructions = parse(f)
  instructions.each do |instruction|
    crates = stacks[instruction[1] - 1].pop(instruction[0])
    stacks[instruction[2] - 1].push(crates).flatten!
  end
  stacks.compact.map { |s| s[-1] }.join
end

class TestAoc20225 < Minitest::Test
  def test_solve_pt1
    assert_equal("CMZ", solve_pt1("./input/aoc2022-5-1.test.txt"))
  end

  def test_solve_pt2
    assert_equal("MCD", solve_pt2("./input/aoc2022-5-1.test.txt"))
  end

  def test_parse
    # assert_nil(parse("./aoc/2022/input/22-5.test.txt"))
  end
end

p solve_pt1("./input/aoc2022-5-1.txt")
p solve_pt2("./input/aoc2022-5-1.txt")
