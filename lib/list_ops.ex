defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  def count([]), do: 0

  def count(list) do
    [_head | tail] = list
    1 + count(tail)
  end

  def reverse(list) do
    reverse(list, [])
  end

  def reverse([], reversed_list), do: reversed_list

  def reverse([head | tail], reversed_list) do
    reverse(tail, [head | reversed_list])
  end

  def map([], _fun), do: []

  def map(list, fun) do
    [head | tail] = list
    [fun.(head) | map(tail, fun)]
  end

  def filter([], _fun), do: []

  def filter(list, fun) do
    [head | tail] = list

    if fun.(head) do
      [head | filter(tail, fun)]
    else
      filter(tail, fun)
    end
  end

  def foldl([], acc, _fun), do: acc

  def foldl(list, acc, fun) do
    [head | tail] = list
    foldl(tail, fun.(head, acc), fun)
  end

  def foldr(list, acc, fun) do
    reversed_list = reverse(list)
    foldl(reversed_list, acc, fun)
  end

  def append([], list_b), do: list_b

  def append(list_a, []), do: list_a

  def append(list_a, list_b) do
    [a_head | a_tail] = list_a
    [a_head | append(a_tail, list_b)]
  end

  def concat([]), do: []

  def concat(ll) do
    [head | tail] = ll
    append(head, concat(tail))
  end

  # concat breakdown

  # APPEND 1
  # ll = [[1, 2], [3], [], [4, 5, 6]]
  # hd = [1, 2]
  # tl = [[3], [], [4, 5, 6]]
  # append([1, 2], concat([[3], [], [4, 5, 6]]))
  # continue concat

  # APPEND 2
  # ll = [[3], [], [4, 5, 6]]
  # hd = [3]
  # tl = [[], [4, 5, 6]]
  # append([3], concat([[], [4, 5, 6]]))
  # continue concat

  # APPEND 3
  # ll = [[], [4, 5, 6]]
  # hd = []
  # tl = [[4, 5, 6]]
  # append([], concat([[4, 5, 6]]))
  # continue concat

  # APPEND 4
  # ll = [[4, 5, 6]]
  # hd = [4, 5, 6]
  # tl = []
  # append([4, 5, 6], concat([]))
  # continue concat

  # call APPEND 4
  # list_a = [4, 5, 6]
  # list_b = []
  # append([4, 5, 6], [])
  # [4, 5, 6]

  # call APPEND 3
  # list_a = []
  # list_b = [4, 5, 6]
  # append([], [4, 5, 6])
  # [4, 5, 6]

  # call APPEND 2
  # list_a = [3]
  # list_b = [4, 5, 6]
  # append([3], [4, 5, 6])
  # [3, 4, 5, 6]

  # call APPEND 1
  # list_a = [1, 2]
  # list_b = [3, 4, 5, 6]
  # append([1, 2], [3, 4, 5, 6])
  # [1, append([2], [3, 4, 5, 6])]
  # [1, 2, 3, 4, 5, 6]
end
