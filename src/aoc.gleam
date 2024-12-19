import gleam/int
import gleam/io
import gleam/list
import gleam/regexp
import simplifile

pub fn main() {
  let assert Ok(value) = simplifile.read(from: "C:/work/aoc/aoc.txt")

  let result =
    parse_dos(value)
    |> parse_instructions()
    |> run_calculations()
    |> sumup

  io.println("total: " <> int.to_string(result))
}

pub fn parse_dos(input: String) -> String {
  let assert Ok(exp) = regexp.from_string("(don?'?t?\\(\\))")
  let #(acc, values) =
    regexp.split(with: exp, content: input)
    |> list.map_fold(True, fn(should, element) {
      case should, element {
        _, "do()" -> #(True, "")
        _, "don't()" -> #(False, "")
        True, value -> #(True, value)
        _, _ -> #(should, "")
      }
    })
  let assert Ok(values) =
    values
    |> list.reduce(fn(acc, element) { acc <> element })
  values
}

pub fn parse_instructions(input: String) -> List(String) {
  let assert Ok(exp) = regexp.from_string("mul\\([0-9]+,[0-9]+\\)")

  regexp.scan(with: exp, content: input)
  |> list.map(fn(item) { item.content })
}

pub fn run_calculations(calculations: List(String)) -> List(Int) {
  let assert Ok(nums) = regexp.from_string("[0-9]+")
  calculations
  |> list.map(fn(calculation) { regexp.scan(with: nums, content: calculation) })
  |> list.map(fn(calculation) {
    let assert [first, second] = calculation
    let assert Ok(first) = int.parse(first.content)
    let assert Ok(second) = int.parse(second.content)
    first * second
  })
}

pub fn sumup(values: List(Int)) -> Int {
  let assert Ok(sum) =
    values
    |> list.reduce(fn(acc, value) { value + acc })
  sum
}
