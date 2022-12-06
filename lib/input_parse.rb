def strip_newlines(strs)
  strs.map { |str| str.delete_suffix("\n") }
end

def get_input_str_arr(filename)
  true_input = strip_newlines(File.readlines(filename)) if File.exist?(filename)

  puts "input not read" if true_input.empty?
  true_input
end

# For input like:
# a
# b
#
# abc
#
# a
# b
# c
def str_groups_separated_by_blank_lines(original_filename)
  groups = []
  curr_group = []

  get_input_str_arr(original_filename).each do |str|
    if str == ""
      groups << curr_group
      curr_group = []
      next
    end

    curr_group << str
  end

  groups << curr_group
  groups
end

# For input like:
# here-is-some-text
def get_input_str(original_filename)
  get_input_str_arr(original_filename)[0]
end

# For input like:
# 1,2,3
def get_single_line_input_int_arr(original_filename, separator: ",")
  get_input_str(original_filename).split(separator).map(&:to_i)
end

# For input like:
# 1
# 2
# 3
def get_multi_line_input_int_arr(original_filename)
  get_input_str_arr(original_filename).map(&:to_i)
end

# For input like:
# 5 1 9 5
# 7 5 3
# 2 4 6 8
def get_multi_line_multi_value_input_int_arr(original_filename, separator: ",")
  get_input_str_arr(original_filename).map { |str_arr| str_arr.split(separator).map(&:to_i) }
end
