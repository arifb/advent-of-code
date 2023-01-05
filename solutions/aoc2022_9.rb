require "./lib/input_parse"
require "minitest/autorun"

class RopeBridge
  def initialize(filepath)
    @moves = get_input_str_arr(filepath)
    @head, @tail = [0, 0], [0, 0]
    @head_touches, @tail_touches = [@head], [@tail]
  end

  def solve_pt1
    moves.each do |move|
      dir, magnitude = move.split(" ")
      magnitude = magnitude.to_i
      case dir
      when "R"
        magnitude.times do |_i|
          @head = [@head[0] + 1, @head[1]]
          move_tail
        end
      when "L"
        magnitude.times do |_i|
          @head = [@head[0] - 1, @head[1]]
          move_tail
        end
      when "U"
        magnitude.times do |_i|
          @head = [@head[0], @head[1] + 1]
          move_tail
        end
      when "D"
        magnitude.times do |_i|
          @head = [@head[0], @head[1] - 1]
          move_tail
        end
      end
    end
    @tail_touches.uniq.count
  end

  def move_tail
    @head_touches.push(@head)
    @tail = get_tail_coord(@head, @tail)
    @tail_touches.push(@tail)
  end

  private

  attr_reader :moves
end

def solve_pt2(filepath)
  moves = get_input_str_arr(filepath)
  head = [0, 0]
  tails = Array.new(9) { |i| [0, 0] }
  head_touches = [head]
  tail_touches = [head]
  moves.each do |move|
    dir, magnitude = move.split(" ")
    magnitude = magnitude.to_i
    case dir
    when "R"
      magnitude.times do |_i|
        head = [head[0] + 1, head[1]]
        head_touches.push(head)
        tails[0] = get_tail_coord(head, tails[0])
        1.upto(8) do |i|
          prev = tails[i]
          tails[i] = get_tail_coord(tails[i - 1], tails[i])
          tail_touches.push(tails[i]) if i == 8
          break if tails[i] == prev
        end
      end
    when "L"
      magnitude.times do |_i|
        head = [head[0] - 1, head[1]]
        head_touches.push(head)
        tails[0] = get_tail_coord(head, tails[0])
        1.upto(8) do |i|
          prev = tails[i]
          tails[i] = get_tail_coord(tails[i - 1], tails[i])
          tail_touches.push(tails[i]) if i == 8
          break if tails[i] == prev
        end
      end
    when "U"
      magnitude.times do |_i|
        head = [head[0], head[1] + 1]
        head_touches.push(head)
        tails[0] = get_tail_coord(head, tails[0])
        1.upto(8) do |i|
          prev = tails[i]
          tails[i] = get_tail_coord(tails[i - 1], tails[i])
          tail_touches.push(tails[i]) if i == 8
          break if tails[i] == prev
        end
      end
    when "D"
      magnitude.times do |_i|
        head = [head[0], head[1] - 1]
        head_touches.push(head)
        tails[0] = get_tail_coord(head, tails[0])
        1.upto(8) do |i|
          prev = tails[i]
          tails[i] = get_tail_coord(tails[i - 1], tails[i])
          tail_touches.push(tails[i]) if i == 8
          break if tails[i] == prev
        end
      end
    end
  end
  tail_touches.compact.uniq.count
end

def get_tail_coord(head, tail)
  # same x
  if head[0] == tail[0]
    if head[1] - tail[1] > 1
      [head[0], tail[1] + 1]
    elsif tail[1] - head[1] > 1
      [head[0], tail[1] - 1]
    else
      [head[0], tail[1]]
    end
  # same y
  elsif head[1] == tail[1]
    if head[0] - tail[0] > 1
      [tail[0] + 1, tail[1]]
    elsif tail[0] - head[0] > 1
      [tail[0] - 1, tail[1]]
    else
      [tail[0], tail[1]]
    end
  # need a diagonal move
  elsif head[1] - tail[1] > 1
    (head[0] > tail[0]) ? [tail[0] + 1, tail[1] + 1] : [tail[0] - 1, tail[1] + 1]
  elsif head[1] - tail[1] < -1
    (head[0] > tail[0]) ? [tail[0] + 1, tail[1] - 1] : [tail[0] - 1, tail[1] - 1]
  elsif head[0] - tail[0] < -1
    (head[1] > tail[1]) ? [tail[0] - 1, tail[1] + 1] : [tail[0] - 1, tail[1] - 1]
  elsif head[0] - tail[0] > 1
    (head[1] < tail[1]) ? [tail[0] + 1, tail[1] - 1] : [tail[0] + 1, tail[1] + 1]
  else
    tail
  end
end

class TestAoc20229 < Minitest::Test
  def test_solve_pt1
    assert_equal(13, RopeBridge.new("./input/aoc2022-9-1.test.txt").solve_pt1)
  end

  def test_solve_pt2
    assert_equal(1, solve_pt2("./input/aoc2022-9-1.test.txt"))
    assert_equal(36, solve_pt2("./input/aoc2022-9-2.test.txt"))
  end
end

p RopeBridge.new("./input/aoc2022-9-1.txt").solve_pt1
p solve_pt2("./input/aoc2022-9-1.txt")
