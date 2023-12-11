puts \
  ARGF
  .readlines
  .tap { _1.class.define_method(:pairs) { each_cons 2 } }
  .tap { _1.class.define_method(:uniform?) { uniq.one? } }
  .tap { _1.class.define_method(:difference) { last - first } }
  .tap { _1.class.define_method(:differences) { pairs.map &:difference } }
  .tap { _1.class.define_method(:next) { uniform? ? last : last + differences.next } }
  .map { _1.split ' ' }
  .map { _1.map &:to_i }
  .map { _1.next }
  .sum
