import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(value) = simplifile.read(from: "C:/work/aoc/aoc.txt")
  let #(even, odd) = parse_and_sort(value)

  let data_points = similarity(even, odd)
  io.debug(data_points)

  sum(data_points)
  |> result.map(fn(result) { "here is the result: " <> int.to_string(result) })
  |> result.unwrap("")
  |> io.println()
}

pub fn sum(data_points: List(Int)) {
  data_points
  |> list.reduce(fn(acc, distance) { acc + distance })
}

pub fn similarity(even, odd) {
  even
  |> list.map(fn(item) {
    item * list.count(odd, fn(target_item) { item == target_item })
  })
}

pub fn parse_and_sort(input: String) -> #(List(Int), List(Int)) {
  let #(even, odd) =
    string.split(input, "\r\n")
    |> list.flat_map(fn(line) { string.split(line, "   ") })
    |> list.map(int.parse)
    |> list.map(result.unwrap(_, 0))
    |> list.index_map(fn(item, index) { #(item, index) })
    |> list.partition(fn(item) { int.is_even(item.1) })

  #(
    even
      |> list.map(fn(item: #(Int, Int)) { item.0 })
      |> list.sort(int.compare),
    odd
      |> list.map(fn(item: #(Int, Int)) { item.0 })
      |> list.sort(int.compare),
  )
}
