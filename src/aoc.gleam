import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub type SafetyBound {
  Up
  Down
  Out
}

pub fn main() {
  let assert Ok(value) = simplifile.read(from: "C:/work/aoc/aoc.txt")
  let records = parse(string.trim(value))

  io.debug(records)
  io.debug("length: " <> int.to_string(list.length(records)))

  let count =
    records
    |> check_safety()
    |> list.count(fn(entry) { entry == True })

  io.println("safe: " <> int.to_string(count))
}

pub fn check_safety(records: List(List(Int))) -> List(Bool) {
  records
  |> list.map(convert_to_diffs)
  |> list.map(evaluate_safe)
}

pub fn convert_to_diffs(record: List(Int)) -> List(SafetyBound) {
  list.window_by_2(record)
  |> list.map(fn(item) {
    case item.1 - item.0 {
      result if result > 0 && result <= 3 -> Up
      result if result < 0 && result >= -3 -> Down
      _ -> Out
    }
  })
}

pub fn evaluate_safe(record: List(SafetyBound)) -> Bool {
  list.window_by_2(record)
  |> list.all(fn(entry) {
    entry.0 != Out && entry.1 != Out && entry.0 == entry.1
  })
}

fn parse_rows(input: String) -> List(String) {
  string.split(input, "\n")
  |> list.map(string.trim)
}

fn parse_records(rows: List(String)) -> List(List(Int)) {
  rows
  |> list.map(fn(row) {
    string.split(row, " ")
    |> list.map(int.parse)
    |> list.map(result.unwrap(_, 0))
  })
}

pub fn parse(input: String) -> List(List(Int)) {
  input
  |> parse_rows()
  |> parse_records()
}
