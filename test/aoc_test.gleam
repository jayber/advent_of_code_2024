import aoc.{
  Down, Out, Up, check_dampener, check_record, check_safety, convert_to_diffs,
  evaluate_safe, drop_by_index, parse,
}
import gleeunit
import gleeunit/should

pub fn main() {
    gleeunit.main()
//  gen_var_test()
}

pub fn parse_test() {
  let records = parse("5 6 1 2 3 4\r\n11 22 3 7 0\r\n3 4 7 8 10\r\n0")
  should.equal(records, [
    [5, 6, 1, 2, 3, 4],
    [11, 22, 3, 7, 0],
    [3, 4, 7, 8, 10],
    [0],
  ])
}

pub fn drop_by_index_test() {
  let assert [2, 3] = drop_by_index([1, 2, 3], 0)
  let assert [1, 3] = drop_by_index([1, 2, 3], 1)
  let assert [1, 2] = drop_by_index([1, 2, 3], 2)
}

pub fn check_dampener_test() {
  let assert True = check_dampener([10, 2, 3])
  let assert True = check_dampener([1, 2, 30])
  let assert False = check_dampener([10, 2, 30])
}

pub fn check_record_test() {
  let assert True = check_record([1, 2, 3])
  let assert True = check_record([10, 2, 3])
  let assert False = check_record([2, 2, 2])
}

pub fn check_safety_test() {
  let assert [False, False, True, True, False, True] =
    check_safety([
      [5, 6, 1, 2, 3, 4],
      [11, 22, 3, 7, 0],
      [3, 4, 7, 8, 10],
      [3, 4, 4, 7, 8, 10],
      [3, 4, 4, 4, 7, 8, 10],
      [0],
    ])
}

pub fn convert_to_diffs_test() {
  let assert [Up, Out, Up, Up, Down] = convert_to_diffs([5, 6, 1, 2, 4, 3])
  let assert [Up, Out, Up, Up, Up] = convert_to_diffs([3, 4, 4, 7, 8, 10])
  let assert [] = convert_to_diffs([0])
}

pub fn evaluate_safe_test() {
  let assert False = evaluate_safe([Up, Out, Up, Up, Down])
  let assert True = evaluate_safe([Up, Up, Up, Up, Up])
  let assert True = evaluate_safe([Down, Down, Down, Down, Down])
  let assert True = evaluate_safe([])
}
