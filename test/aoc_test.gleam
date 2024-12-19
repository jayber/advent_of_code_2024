import aoc.{parse_instructions, run_calculations, sumup}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
  //  ingest_instruction_test()
}

pub fn parse_instructions_test() {
  should.equal(parse_instructions("mul(1,1)"), ["mul(1,1)"])
  should.equal(parse_instructions("fffmul(1,1)"), ["mul(1,1)"])
  should.equal(parse_instructions("mul(1,1)xxx"), ["mul(1,1)"])
  should.equal(parse_instructions("09(b)mul(1,1)xxx"), ["mul(1,1)"])
  should.equal(parse_instructions("mul(1,1)mul(2,2)"), ["mul(1,1)", "mul(2,2)"])
  should.equal(
    parse_instructions(
      "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)\r\n+mul(32,64]then(mul(11,8)mul(8,5))",
    ),
    ["mul(2,4)", "mul(5,5)", "mul(11,8)", "mul(8,5)"],
  )
}

pub fn run_calculations_test() {
  should.equal(run_calculations(["mul(2,2)"]), [4])
  should.equal(run_calculations(["mul(101,24)"]), [2424])
  should.equal(run_calculations(["mul(2,2)", "mul(101,24)"]), [4, 2424])
}

pub fn sumup_test() {
  should.equal(sumup([4]), 4)
  should.equal(sumup([4, 5]), 9)
}
