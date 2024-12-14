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
    |> list.count(fn(entry) { entry })

  io.println("safe: " <> int.to_string(count))
}

pub fn check_safety(records: List(List(Int))) -> List(Bool) {
  records
  |> list.map(check_record)
}

pub fn check_record(record: List(Int)) -> Bool {
  case convert_to_diffs(record) |> evaluate_safe {
    False -> check_dampener(record)
    value -> value
  }
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
  record
  |> list.all(fn(entry) { entry != Out })
  && list.window_by_2(record)
  |> list.all(fn(entry) { entry.0 == entry.1 })
}

pub fn check_dampener(record: List(Int)) -> Bool {
  generate_variants(record,0,[])
  |> list.any(fn(variant) {
    variant
    |> convert_to_diffs()
    |> evaluate_safe
  })
}

fn generate_variants(
  record: List(Int),
  position: Int,
  acc: List(List(Int))
) -> List(List(Int)) {
  let acc = [drop_by_index(record, position), ..acc]

  case position == list.length(record) {
    True -> acc
    False -> generate_variants(record, position + 1, acc)
  }
}

pub fn drop_by_index(record, position) {
  list.append(list.take(record, position), list.drop(record, position + 1))
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
