import aoc.{Down, Out, Up, check_safety, convert_to_diffs, evaluate_safe, parse}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
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

pub fn check_safety_test() {
  let assert [False, False, True, True] =
    check_safety([[5, 6, 1, 2, 3, 4], [11, 22, 3, 7, 0], [3, 4, 7, 8, 10], [0]])
}

pub fn convert_to_diffs_test() {
  let assert [Up, Out, Up, Up, Down] = convert_to_diffs([5, 6, 1, 2, 4, 3])
  let assert [] = convert_to_diffs([0])
}

pub fn evauate_safe_test() {
  let assert False = evaluate_safe([Up, Out, Up, Up, Up])
  let assert False = evaluate_safe([Up, Up, Up, Up, Down])
  let assert True = evaluate_safe([Up, Up, Up, Up, Up])
  let assert True = evaluate_safe([Down, Down, Down, Down, Down])
  let assert True = evaluate_safe([])
}
