#ancestors is a method in Module class.
#It Returns a list of modules included in invoking class/module (including class/module itself)

String.ancestors #[String, Comparable, Object, Kernel, BasicObject]

module A
end

module B
  include A
end

class C
  include B
end

C < B #true : because C includes B
C < A #true

A.ancestors #
B.ancestors #
C.ancestors #

C.include?(B) #
A.include?(B) #

A.included_modules #[]
B.included_modules #[A]
C.included_modules #[B, A, Kernel]