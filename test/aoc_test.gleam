import gleeunit
import gleeunit/should
import aoc.{parse_and_sort,similarity,sum}

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn parse_and_sort_test() {
  let #(even, odd) = parse_and_sort("5   6\r\n1   2\r\n3   4")

  should.equal(even, [1,3,5])
  should.equal(odd, [2,4,6])
}

pub fn similarity_test() {
  let assert [2,0,3] = similarity([1,2,3], [1,1,3])
}

pub fn sum_test() {
  let assert Ok(5) = sum([2,0,3])
}
