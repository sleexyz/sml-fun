signature MONOID =
sig
    type t
    val append : t * t -> t
    val zero : t
end

structure Additive =
struct
  type t = int
  val append = (fn (x, y) => x + y)
  val zero = 0
  val baz = 100
end

structure Multiplicative =
struct
  type t = int
  val append = (fn (x, y) => x * y)
  val zero = 1
end

functor Action (M : MONOID) : MONOID =
struct
  type t = M.t -> M.t

  val append = fn (f, g) => fn x => f (g (x))
  val zero = fn (x) => x
end

structure AdditiveAction = Action(Additive)

val foo = Additive.zero + Multiplicative.zero (* val foo = 1 *)
