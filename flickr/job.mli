open Spotlib.Spot

type (+'a, 'error) t

include Monad_intf.T2 with type ('a, 'error) t := ('a, 'error) t

type ('a, 'error) job = ('a, 'error) t

val empty : (unit, 'error) t

val create : (unit -> ('a, 'error) Result.t) -> ('a, 'error) t

val retry
  : ('st -> 'error -> ('st, 'error) Result.t)
  -> 'st
  -> ('a, 'error) t
  -> ('a, 'error) t

val run : ('a, 'error) t -> ('a, 'error * ('a, 'error) t) Result.t 

module Seq : sig
  type ('a, 'error) t = ( [`None | `Some of 'a * ('a, 'error) t], 'error ) job

  val flatten : ('a list, 'error) t -> ('a, 'error) t
end

val of_seq : ('a, 'error) Seq.t -> ('a list, 'error) t

