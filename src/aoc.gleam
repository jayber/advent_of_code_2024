import simplifile
import gleam/io
import gleam/string
import gleam/list
import gleam/int
import gleam/result

pub fn main() {
  let assert Ok(value) =  simplifile.read(from: "C:/work/aoc/aoc.txt")
  let #(even, odd) = parse_and_sort(value)

  let data_points = calc_distance(even, odd)
  io.debug(data_points)

  sum(data_points)
  |> result.map(fn(result) {"here is the result: " <> int.to_string(result)})
  |> result.unwrap("")
  |> io.println()
}

fn sum(data_points) {
  list.map(data_points,fn(item: #(#(Int, Int), Int)) {item.1})
  |> list.reduce(fn(acc, distance) { acc + distance})
}

fn calc_distance(even, odd) {
  let assert Ok(pairs) = list.strict_zip(even, odd)
  pairs
  |> list.map(fn(pair: #(Int, Int)) {#(pair, int.absolute_value(pair.0 - pair.1))})
}

fn parse_and_sort(input: String) -> #(List(Int), List(Int)) {
  let #(even, odd) = string.split(input, "\r\n")
  |> list.flat_map(fn(line) {string.split(line, "   ")})
  |> list.map(int.parse)
  |> list.map(result.unwrap(_,0))
  |> list.index_map(fn(item, index) {#(item,index)})
  |> list.partition(fn(item) {int.is_even(item.1) })

  #(even
  |> list.map(fn(item: #(Int, Int)) {item.0})
  |> list.sort(int.compare),
  odd
  |> list.map(fn(item: #(Int, Int)) {item.0})
  |> list.sort(int.compare)
  )
}
