require "test/unit"
require_relative "../same_side_of_centerline"

class SameSideOfCenterlineTest < Test::Unit::TestCase

  # For N = 1
  class N1 < Test::Unit::TestCase
    setup do
      @rule = SameSideOfCenterline.new(1, 0.0)
    end

    test "detects violations for n = 1" do
      violations = @rule.apply([10, 0, -10])
      assert_equal(violations, [true, false, true])
    end

    test "skips nil values" do
      violations = @rule.apply([nil, 0, nil])
      assert_equal(violations, [false, false, false])
    end
  end

  # For N = 3
  class N3< Test::Unit::TestCase
    setup do
      @rule = SameSideOfCenterline.new(3, 0.0)
    end

    test "detects violations for n = 3" do
      violations = @rule.apply([1, 1, 1, 0, -1, -1, -1])
      assert_equal(violations, [false, false, true, false, false, false, true])
    end

    test "skips non-sequential violations" do
      violations = @rule.apply([1, 0, 1, 1, 0, -1, -1, 0, -1])
      assert_equal(violations, [false, false, false, false, false, false, false, false, false])
    end

    test "skips nil values" do
      violations = @rule.apply([-1, nil, -1, 0, 1, nil, 1])
      assert_equal(violations, [false, false, false, false, false, false, false])
    end

    test "detects no violations when fewer than n points" do
      violations = @rule.apply([1, 1])
      assert_equal(violations, [false, false])

      violations = @rule.apply([1])
      assert_equal(violations, [false])

      violations = @rule.apply([])
      assert_equal(violations, [])
    end
  end

  # For nil center
  class NilCenter < Test::Unit::TestCase

    test "skips nil center" do
      # N = 1
      rule = SameSideOfCenterline.new(1, nil)
      violations = rule.apply([10, 0, -10])
      assert_equal(violations, [false, false, false])

      # N = 3
      rule = SameSideOfCenterline.new(3, nil)
      violations = rule.apply([1, 1, 1, 0, -1, -1, -1])
      assert_equal(violations, [false, false, false, false, false, false, false])
    end
  end
end
