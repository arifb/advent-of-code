require "./lib/input_parse"
require "minitest/autorun"

def parse(filepath)
  commands_or_output = get_input_str_arr(filepath)
  current = Directory.new("/", nil)
  directories = [current]
  commands_or_output[1..].each do |command_or_output|
    case command_or_output
    when /\$/
      ops = command_or_output.split(" ")[1..]
      if ops[0] == "cd"
        if ops[1] == ".."
          current = current.parent
        else
          newdir = Directory.new(ops[1], current)
          current.subdirectories.push(newdir)
          current = newdir
          directories.push(newdir)
        end
      elsif ops[0] == "ls"
      end
    when /\d+/
      size, name = command_or_output.split(" ")
      current.files[name] = size.to_i
    end
  end
  directories
end

class Directory
  attr_accessor :subdirectories, :files
  attr_reader :name, :parent
  def initialize(name, parent)
    @name = name
    @files = {}
    @subdirectories = []
    @parent = parent
  end

  def to_s
    "#{name}, #{total_size}, #{subdirectories.map(&:name).join("; ")}"
  end

  def total_size
    files.values.sum + subdirectories.map(&:total_size).sum
  end
end

def solve_pt1(directories)
  directories.filter { |d| d.total_size < 100000 }.map(&:total_size).reduce(:+)
end

def solve_pt2(directories)
  total_space = 70000000
  needed_space = 30000000
  root = directories.first
  free_space = total_space - root.total_size
  needed_space -= free_space
  directories.filter { |d| d.total_size >= needed_space }.map(&:total_size).min
end

class TestAoc20226 < Minitest::Test
  def test_solve_pt1
    directories = parse("./input/aoc2022-7-1.test.txt")
    assert_equal(95437, solve_pt1(directories))
  end

  def test_solve_pt2
    directories = parse("./input/aoc2022-7-1.test.txt")
    assert_equal(24933642, solve_pt2(directories))
  end
end

directories = parse("./input/aoc2022-7-1.txt")
p solve_pt1(directories)
p solve_pt2(directories)
